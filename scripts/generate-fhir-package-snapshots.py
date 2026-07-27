from __future__ import annotations

import argparse
import glob
import json
import re
import subprocess
import tarfile
import tempfile
import urllib.request
from pathlib import Path


FHIR_PACKAGES_DIR = Path.home() / ".fhir" / "packages"
VALIDATOR_JAR = Path(tempfile.gettempdir()) / "validator_cli.jar"
VALIDATOR_URL = (
    "https://github.com/hapifhir/org.hl7.fhir.core/releases/download/"
    "6.9.7/validator_cli.jar"
)
SUPPORTED_PACKAGES = {
    "de.gematik.dipag": (
        "de.basisprofil.r4#1.5.4",
        "dvmd.kdl.r4#2025.0.1",
        "de.ihe-d.terminology#3.0.1",
    ),
}


def dependency_version(config_path: Path, package_name: str) -> str | None:
    content = config_path.read_text(encoding="utf-8")
    match = re.search(
        rf"^\s*{re.escape(package_name)}:\s*([^\s#]+)",
        content,
        re.MULTILINE,
    )
    return match.group(1) if match else None


def package_dir(package_name: str, version: str) -> Path:
    return FHIR_PACKAGES_DIR / f"{package_name}#{version}" / "package"


def ensure_package(package_name: str, version: str) -> Path:
    target = package_dir(package_name, version)
    if (target / "package.json").is_file():
        return target

    cache_root = target.parent
    cache_root.mkdir(parents=True, exist_ok=True)
    url = f"https://packages2.fhir.org/packages/{package_name}/{version}"
    with tempfile.NamedTemporaryFile(suffix=".tgz", delete=False) as archive:
        archive_path = Path(archive.name)
    try:
        urllib.request.urlretrieve(url, archive_path)
        with tarfile.open(archive_path, "r:gz") as package_archive:
            root = cache_root.resolve()
            for member in package_archive.getmembers():
                destination = (cache_root / member.name).resolve()
                if member.issym() or member.islnk():
                    raise RuntimeError(f"Archive link is not allowed: {member.name}")
                if destination != root and root not in destination.parents:
                    raise RuntimeError(f"Unsafe archive member: {member.name}")
            package_archive.extractall(cache_root)
    finally:
        archive_path.unlink(missing_ok=True)
    if not (target / "package.json").is_file():
        raise RuntimeError(f"Downloaded package is incomplete: {target}")
    return target


def structure_definitions(target: Path) -> list[Path]:
    return [
        Path(path)
        for path in sorted(glob.glob(str(target / "StructureDefinition-*.json")))
        if not path.endswith(".snapshot.json")
    ]


def has_snapshot(path: Path) -> bool:
    resource = json.loads(path.read_text(encoding="utf-8"))
    return bool(resource.get("snapshot", {}).get("element"))


def ensure_validator() -> None:
    if VALIDATOR_JAR.is_file() and VALIDATOR_JAR.stat().st_size > 10_000_000:
        return
    urllib.request.urlretrieve(VALIDATOR_URL, VALIDATOR_JAR)


def prepare_package(package_name: str, version: str) -> None:
    target = ensure_package(package_name, version)
    definitions = structure_definitions(target)
    missing = [path for path in definitions if not has_snapshot(path)]
    if not definitions:
        raise RuntimeError(f"No StructureDefinitions found in {package_name}#{version}")
    if not missing:
        print(f"{package_name}#{version}: all snapshots are present")
        return

    ensure_validator()
    command = [
        "java",
        "-jar",
        str(VALIDATOR_JAR),
        "snapshot",
        "-version",
        "4.0.1",
    ]
    for dependency in SUPPORTED_PACKAGES[package_name]:
        command.extend(["-ig", dependency])
    command.extend(["-ig", f"{package_name}#{version}"])
    command.extend(str(path) for path in missing)
    command.extend(["-outputSuffix", "snapshot.json"])
    result = subprocess.run(
        command, capture_output=True, text=True, timeout=300, check=False
    )
    if result.returncode != 0:
        raise RuntimeError((result.stderr or result.stdout)[-4000:])

    for definition in missing:
        generated = Path(f"{definition}.snapshot.json")
        original_resource = json.loads(definition.read_text(encoding="utf-8"))
        generated_resource = json.loads(generated.read_text(encoding="utf-8"))
        snapshot = generated_resource.get("snapshot", {})
        if not snapshot.get("element"):
            raise RuntimeError(f"Generated snapshot is empty for {definition.name}")
        original_resource["snapshot"] = snapshot
        definition.write_text(
            json.dumps(original_resource, indent=2) + "\n", encoding="utf-8"
        )
        generated.write_text("", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--package",
        action="append",
        choices=sorted(SUPPORTED_PACKAGES),
        dest="packages",
    )
    parser.add_argument("--config", type=Path, default=Path("sushi-config.yaml"))
    args = parser.parse_args()
    for package_name in args.packages or list(SUPPORTED_PACKAGES):
        version = dependency_version(args.config, package_name)
        if version is not None:
            prepare_package(package_name, version)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
