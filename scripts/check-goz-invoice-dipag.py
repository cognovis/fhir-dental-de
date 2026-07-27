from __future__ import annotations

import json
import subprocess
import tempfile
import urllib.request
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
GENERATED = ROOT / "fsh-generated" / "resources"
VALIDATOR_JAR = Path(tempfile.gettempdir()) / "validator_cli.jar"
VALIDATOR_URL = (
    "https://github.com/hapifhir/org.hl7.fhir.core/releases/download/"
    "6.9.7/validator_cli.jar"
)


def load(name: str) -> dict:
    return json.loads((GENERATED / name).read_text(encoding="utf-8"))


def money(component: dict) -> float:
    return float(component["amount"]["value"])


def validate_negative_fixture(path: Path) -> None:
    if not VALIDATOR_JAR.is_file() or VALIDATOR_JAR.stat().st_size < 10_000_000:
        urllib.request.urlretrieve(VALIDATOR_URL, VALIDATOR_JAR)
    command = [
        "java",
        "-jar",
        str(VALIDATOR_JAR),
        str(path),
        "-version",
        "4.0.1",
        "-ig",
        "de.gematik.dipag#1.0.8",
        "-ig",
        "de.cognovis.fhir.praxis#0.88.0",
        "-ig",
        str(GENERATED / "StructureDefinition-goz-charge-item.json"),
        "-ig",
        str(GENERATED / "StructureDefinition-goz-invoice-de.json"),
        "-tx",
        "n/a",
    ]
    result = subprocess.run(
        command,
        capture_output=True,
        text=True,
        timeout=180,
        check=False,
    )
    output = result.stdout + result.stderr
    assert result.returncode != 0, "Negative GOZ invoice unexpectedly validated"
    assert "generic-charge" in output
    assert "goz-charge-item" in output.lower()


def main() -> int:
    config = (ROOT / "sushi-config.yaml").read_text(encoding="utf-8")
    assert "de.cognovis.fhir.praxis: 0.88.0" in config
    assert "de.gematik.dipag: 1.0.8" in config

    profile = load("StructureDefinition-goz-invoice-de.json")
    assert (
        profile["baseDefinition"]
        == "https://gematik.de/fhir/dipag/StructureDefinition/dipag-rechnung"
    )
    charge_item = next(
        element
        for element in profile["differential"]["element"]
        if element["path"] == "Invoice.lineItem.chargeItem[x]"
    )
    assert charge_item["type"][0]["targetProfile"] == [
        "https://fhir.cognovis.de/dental/StructureDefinition/goz-charge-item"
    ]

    names = [
        "Invoice-ExampleGozHealingInvoice.json",
        "Invoice-ExampleGozMixedTaxInvoice.json",
        "Invoice-ExampleGozAgreementInvoice.json",
    ]
    examples = [load(name) for name in names]
    canonical = "https://fhir.cognovis.de/dental/StructureDefinition/goz-invoice-de"
    for invoice in examples:
        assert canonical in invoice["meta"]["profile"]
        assert invoice["account"]["reference"] == "Account/acct-dental-02-pkv-q1"
        for line in invoice["lineItem"]:
            base = next(
                component
                for component in line["priceComponent"]
                if component["type"] == "base"
            )
            assert money(base) > 0

    mixed = examples[1]
    taxed_line = mixed["lineItem"][1]
    tax = next(
        component
        for component in taxed_line["priceComponent"]
        if component["type"] == "tax"
    )
    assert money(tax) == 28.50
    assert mixed["totalGross"]["value"] == 365.95
    assert mixed["totalNet"]["value"] == 337.45

    agreement_charge = load("ChargeItem-ExampleGozChargeItemWithAgreement.json")
    agreement = next(
        extension
        for extension in agreement_charge["extension"]
        if extension["url"].endswith("/goz-honorarvereinbarung")
    )
    nested = {extension["url"]: extension for extension in agreement["extension"]}
    assert nested["reimbursementNoticeGiven"]["valueBoolean"] is True
    assert nested["document"]["valueReference"]["reference"].endswith(
        "ExampleGozHonorarvereinbarung"
    )

    negative = json.loads(
        (
            ROOT
            / "test"
            / "fixtures"
            / "goz-invoice-invalid-generic-line.json"
        ).read_text(encoding="utf-8")
    )
    generic_charge = negative["contained"][0]
    assert generic_charge["resourceType"] == "ChargeItem"
    assert "profile" not in generic_charge.get("meta", {})
    assert (
        negative["lineItem"][0]["chargeItemReference"]["reference"]
        == f"#{generic_charge['id']}"
    )
    allowed_target = charge_item["type"][0]["targetProfile"][0]
    assert allowed_target.endswith("/goz-charge-item")
    validate_negative_fixture(
        ROOT / "test" / "fixtures" / "goz-invoice-invalid-generic-line.json"
    )

    repository_text = "\n".join(
        path.read_text(encoding="utf-8")
        for path in ROOT.rglob("*")
        if path.is_file()
        and path.suffix
        in {
            ".fsh",
            ".http",
            ".js",
            ".json",
            ".md",
            ".mjs",
            ".py",
            ".sh",
            ".yaml",
            ".yml",
        }
        and not any(
            part in {
                ".git",
                "dist",
                "fsh-generated",
                "input-cache",
                "output",
                "temp",
            }
            for part in path.parts
        )
    )
    assert ("Praxis" + "InvoiceDE") not in repository_text
    print("GOZ DiPag invoice contract verified")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
