from __future__ import annotations

import importlib.util
import json
import sys
import tempfile
import unittest
from pathlib import Path


SCRIPT_PATH = Path(__file__).with_name("generate-fhir-package-snapshots.py")
SPEC = importlib.util.spec_from_file_location("snapshot_generator", SCRIPT_PATH)
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = MODULE
SPEC.loader.exec_module(MODULE)


class GenerateFhirPackageSnapshotsTest(unittest.TestCase):
    def test_dependency_version_reads_dipag_pin(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            config = Path(directory) / "sushi-config.yaml"
            config.write_text(
                "dependencies:\n  de.gematik.dipag: 1.0.8\n",
                encoding="utf-8",
            )
            self.assertEqual(
                MODULE.dependency_version(config, "de.gematik.dipag"),
                "1.0.8",
            )

    def test_generated_validator_outputs_are_excluded(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            package = Path(directory)
            expected = package / "StructureDefinition-example.json"
            expected.write_text("{}", encoding="utf-8")
            (package / "StructureDefinition-example.json.snapshot.json").write_text(
                "{}", encoding="utf-8"
            )
            self.assertEqual(MODULE.structure_definitions(package), [expected])

    def test_snapshot_requires_elements(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            definition = Path(directory) / "StructureDefinition-example.json"
            definition.write_text(
                json.dumps({"snapshot": {"element": [{"id": "Example"}]}}),
                encoding="utf-8",
            )
            self.assertTrue(MODULE.has_snapshot(definition))


if __name__ == "__main__":
    unittest.main()
