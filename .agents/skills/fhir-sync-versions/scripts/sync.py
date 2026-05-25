#!/usr/bin/env python3
"""Synchronize FHIR version pins against fhir-versions.lock.yaml."""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Literal

import yaml


DEFAULT_REGISTRY = "https://npm.cognovis.de"
NPM_TIMEOUT_SECONDS = 5
REGISTRY_BUDGET_SECONDS = 20
REPO_ROOT_MARKER = "fhir-versions.lock.yaml"
SUSHI_CONSUMERS = (
    Path("~/code/fhir-praxis-de/sushi-config.yaml").expanduser(),
    Path("~/code/fhir-dental-de/sushi-config.yaml").expanduser(),
    Path("~/code/fhir-deidentification-de/sushi-config.yaml").expanduser(),
)
PACKAGE_JSON_CONSUMER_ROOTS = (
    Path("~/code/polaris").expanduser(),
    Path("~/code/mira").expanduser(),
)
PACKAGE_JSON_DEPENDENCY_FIELDS = (
    "dependencies",
    "devDependencies",
    "peerDependencies",
    "optionalDependencies",
    "overrides",
    "resolutions",
)
PACKAGE_JSON_EXCLUDED_DIRS = frozenset(
    {
        ".cache",
        ".claude",
        ".codegen-cache",
        ".git",
        ".next",
        ".turbo",
        "build",
        "coverage",
        "dist",
        "node_modules",
    }
)
PACKAGE_JSON_NON_VERSION_PREFIXES = (
    "file:",
    "git+",
    "github:",
    "http://",
    "https://",
    "link:",
    "portal:",
    "workspace:",
)
GENERATED_PROVENANCE_ROOTS = (
    Path("~/code/polaris/packages/fhir-de/generated").expanduser(),
    Path("~/code/polaris/packages/fhir-de/src/client/generated").expanduser(),
)
GENERATED_PROVENANCE_PATTERNS = (
    re.compile(r"\bpkg:\s+(?P<package>[A-Za-z0-9_.@/-]+)#(?P<version>[^\s)]+)"),
    re.compile(r"\bSource:\s+(?P<package>[A-Za-z0-9_.@/-]+)@(?P<version>[^\s]+)"),
)


@dataclass(frozen=True)
class Drift:
    file: Path
    package: str
    current: str
    expected: str
    action: Literal["UPDATE", "MANIFEST-BEHIND", "REGENERATE"]


@dataclass(frozen=True)
class ConsumerFile:
    path: Path
    kind: str
    dependencies: dict[str, str]
    package_name: str | None = None


@dataclass(frozen=True)
class GeneratedProvenance:
    path: Path
    package: str
    versions: tuple[str, ...]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Reconcile FHIR package version pins against fhir-versions.lock.yaml."
    )
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--dry-run", action="store_true", help="show drift without editing files")
    mode.add_argument("--apply", action="store_true", help="apply edits and run the drift guard")
    parser.add_argument("--manifest", type=Path, help="path to fhir-versions.lock.yaml")
    parser.add_argument("--registry", default=DEFAULT_REGISTRY, help="npm registry URL")
    return parser.parse_args()


def find_manifest(explicit_path: Path | None) -> Path:
    if explicit_path:
        path = explicit_path.expanduser().resolve()
        if not path.is_file():
            raise FileNotFoundError(f"Manifest not found: {path}")
        return path

    current = Path.cwd().resolve()
    for directory in (current, *current.parents):
        candidate = directory / REPO_ROOT_MARKER
        if candidate.is_file():
            return candidate
    raise FileNotFoundError(
        f"Could not find {REPO_ROOT_MARKER} in current directory or parents"
    )


def load_yaml(path: Path) -> dict[str, Any]:
    with path.open(encoding="utf-8") as handle:
        data = yaml.safe_load(handle) or {}
    if not isinstance(data, dict):
        raise ValueError(f"Expected YAML mapping in {path}")
    return data


def build_expected_versions(manifest: dict[str, Any]) -> dict[str, str]:
    expected: dict[str, str] = {}
    for section in ("igs", "packages", "bundles"):
        entries = manifest.get(section, {}) or {}
        if not isinstance(entries, dict):
            raise ValueError(f"Manifest section {section!r} must be a mapping")
        for package_name, package_data in entries.items():
            if isinstance(package_data, dict) and "version" in package_data:
                expected[package_name] = str(package_data["version"])
    return expected


def build_transitive_expected_versions(manifest: dict[str, Any]) -> dict[str, str]:
    expected = build_expected_versions(manifest)
    for bundle_name, bundle_data in (manifest.get("bundles", {}) or {}).items():
        if isinstance(bundle_data, dict) and isinstance(bundle_data.get("dependencies"), dict):
            for package_name, version in bundle_data["dependencies"].items():
                expected.setdefault(package_name, str(version))
            if "version" in bundle_data:
                expected[bundle_name] = str(bundle_data["version"])
    for package_name, package_data in (manifest.get("packages", {}) or {}).items():
        if isinstance(package_data, dict) and isinstance(package_data.get("cross_pins"), dict):
            for dep_name, version in package_data["cross_pins"].items():
                anchor = expected.get(dep_name)
                expected.setdefault(dep_name, anchor or str(version))
    return expected


def repo_root_from_manifest(manifest_path: Path) -> Path:
    return manifest_path.resolve().parent


def package_json_files(repo_root: Path) -> list[Path]:
    packages_dir = repo_root / "packages"
    if not packages_dir.is_dir():
        return []
    return sorted(packages_dir.glob("*/package.json"))


def package_json_files_under(root: Path) -> list[Path]:
    if not root.is_dir():
        return []
    package_files: list[Path] = []
    for directory, dirnames, filenames in os.walk(root):
        dirnames[:] = [
            dirname for dirname in dirnames if dirname not in PACKAGE_JSON_EXCLUDED_DIRS
        ]
        if "package.json" in filenames:
            package_files.append(Path(directory) / "package.json")
    return sorted(package_files)


def external_package_json_files() -> list[Path]:
    files: list[Path] = []
    for root in PACKAGE_JSON_CONSUMER_ROOTS:
        files.extend(package_json_files_under(root))
    return files


def read_sushi_dependencies(path: Path) -> dict[str, str]:
    data = load_yaml(path)
    result: dict[str, str] = {}
    package_id = data.get("id")
    package_version = data.get("version")
    if package_id and package_version is not None:
        result[str(package_id)] = str(package_version)

    dependencies = data.get("dependencies", {}) or {}
    if isinstance(dependencies, dict):
        for package_name, value in dependencies.items():
            if isinstance(value, dict):
                version = value.get("version")
            else:
                version = value
            if version is not None:
                result[str(package_name)] = str(version)
        return result
    if isinstance(dependencies, list):
        for item in dependencies:
            if not isinstance(item, dict):
                continue
            package_name = item.get("package") or item.get("id") or item.get("name")
            version = item.get("version")
            if package_name and version is not None:
                result[str(package_name)] = str(version)
        return result
    raise ValueError(f"Unsupported dependencies format in {path}")


def is_package_json_version_pin(value: Any) -> bool:
    if not isinstance(value, str):
        return value is not None and not isinstance(value, (dict, list))
    stripped = value.strip()
    return not stripped.startswith(PACKAGE_JSON_NON_VERSION_PREFIXES)


def read_package_json_dependencies(path: Path) -> dict[str, str]:
    with path.open(encoding="utf-8") as handle:
        data = json.load(handle)
    result: dict[str, str] = {}
    package_name = data.get("name")
    package_version = data.get("version")
    if package_name and package_version is not None:
        result[str(package_name)] = str(package_version)
    for field in PACKAGE_JSON_DEPENDENCY_FIELDS:
        dependencies = data.get(field, {}) or {}
        if not isinstance(dependencies, dict):
            raise ValueError(f"Expected {field} object in {path}")
        for dependency_name, version in dependencies.items():
            if is_package_json_version_pin(version):
                result[str(dependency_name)] = str(version)
    return result


def read_consumer_file(path: Path) -> ConsumerFile | None:
    if not path.is_file():
        return None
    if path.name == "sushi-config.yaml":
        data = load_yaml(path)
        package_name = data.get("id")
        return ConsumerFile(
            path=path,
            kind="sushi",
            dependencies=read_sushi_dependencies(path),
            package_name=str(package_name) if package_name else None,
        )
    if path.name == "package.json":
        with path.open(encoding="utf-8") as handle:
            data = json.load(handle)
        package_name = data.get("name")
        return ConsumerFile(
            path=path,
            kind="package-json",
            dependencies=read_package_json_dependencies(path),
            package_name=str(package_name) if package_name else None,
        )
    return None


def discover_consumers(repo_root: Path) -> list[ConsumerFile]:
    paths = [
        *SUSHI_CONSUMERS,
        *package_json_files(repo_root),
        *external_package_json_files(),
    ]
    consumers: list[ConsumerFile] = []
    seen: set[Path] = set()
    for path in paths:
        resolved = path.resolve()
        if resolved in seen:
            continue
        seen.add(resolved)
        consumer = read_consumer_file(path)
        if consumer:
            consumers.append(consumer)
    return consumers


def build_effective_expected_versions(
    manifest: dict[str, Any], consumers: list[ConsumerFile]
) -> dict[str, str]:
    expected = build_transitive_expected_versions(manifest)
    for consumer in consumers:
        if consumer.kind != "sushi" or consumer.package_name is None:
            continue
        if consumer.package_name in expected:
            continue
        version = consumer.dependencies.get(consumer.package_name)
        if version is not None:
            expected[consumer.package_name] = version
    return expected


def read_generated_provenance(root: Path) -> list[GeneratedProvenance]:
    if not root.is_dir():
        return []

    versions_by_package: dict[str, set[str]] = {}
    for path in sorted(root.rglob("*.ts")):
        text = path.read_text(encoding="utf-8", errors="ignore")
        for pattern in GENERATED_PROVENANCE_PATTERNS:
            for match in pattern.finditer(text):
                package_name = match.group("package")
                version = match.group("version")
                versions_by_package.setdefault(package_name, set()).add(version)

    return [
        GeneratedProvenance(
            path=root,
            package=package_name,
            versions=tuple(sorted(versions)),
        )
        for package_name, versions in sorted(versions_by_package.items())
    ]


def discover_generated_provenance(
    roots: tuple[Path, ...] = GENERATED_PROVENANCE_ROOTS,
) -> list[GeneratedProvenance]:
    records: list[GeneratedProvenance] = []
    for root in roots:
        records.extend(read_generated_provenance(root))
    return records


def compute_generated_provenance_drifts(
    expected_versions: dict[str, str],
    roots: tuple[Path, ...],
) -> list[Drift]:
    drifts: list[Drift] = []
    for record in discover_generated_provenance(roots):
        expected = expected_versions.get(record.package)
        if expected is None:
            continue
        if record.versions == (expected,):
            continue
        drifts.append(
            Drift(
                file=record.path,
                package=record.package,
                current=", ".join(record.versions),
                expected=expected,
                action="REGENERATE",
            )
        )
    return drifts


def expected_versions_for_consumer(
    manifest: dict[str, Any], consumer: ConsumerFile, global_expected: dict[str, str]
) -> dict[str, str]:
    if consumer.kind != "package-json" or consumer.package_name is None:
        return global_expected

    expected: dict[str, str] = {}
    bundles = manifest.get("bundles", {}) or {}
    packages = manifest.get("packages", {}) or {}
    if consumer.package_name in bundles:
        bundle_data = bundles[consumer.package_name]
        if isinstance(bundle_data, dict):
            if "version" in bundle_data:
                expected[consumer.package_name] = str(bundle_data["version"])
            for package_name, version in (bundle_data.get("dependencies", {}) or {}).items():
                expected[str(package_name)] = str(version)
    elif consumer.package_name in packages:
        package_data = packages[consumer.package_name]
        if isinstance(package_data, dict):
            if "version" in package_data:
                expected[consumer.package_name] = str(package_data["version"])
            for package_name, version in (package_data.get("cross_pins", {}) or {}).items():
                expected[str(package_name)] = str(version)

    for package_name in consumer.dependencies:
        if package_name not in expected and package_name in global_expected:
            expected[package_name] = global_expected[package_name]
    return expected


def compute_drifts(
    consumers: list[ConsumerFile],
    manifest: dict[str, Any],
    generated_roots: tuple[Path, ...] = (),
) -> list[Drift]:
    global_expected = build_effective_expected_versions(manifest, consumers)
    drifts: list[Drift] = []
    for consumer in consumers:
        expected_versions = expected_versions_for_consumer(
            manifest, consumer, global_expected
        )
        for package_name, current in consumer.dependencies.items():
            expected = expected_versions.get(package_name)
            if expected is None:
                continue
            if current != expected:
                action: Literal["UPDATE", "MANIFEST-BEHIND"] = "UPDATE"
                is_ahead = (
                    consumer.kind == "sushi"
                    and consumer.package_name == package_name
                    and version_lt(expected, current)
                )
                if is_ahead:
                    action = "MANIFEST-BEHIND"
                drifts.append(
                    Drift(
                        file=consumer.path,
                        package=package_name,
                        current=current,
                        expected=expected,
                        action=action,
                    )
                )
    drifts.extend(compute_generated_provenance_drifts(global_expected, generated_roots))
    return sorted(drifts, key=lambda drift: (display_path(drift.file), drift.package))


def display_path(path: Path) -> str:
    home = Path.home()
    try:
        return "~/" + str(path.resolve().relative_to(home))
    except ValueError:
        return str(path)


def print_drift_table(drifts: list[Drift]) -> None:
    rows = [
        (
            display_path(drift.file),
            drift.package,
            drift.current,
            drift.expected,
            drift.action,
        )
        for drift in drifts
    ]
    headers = ("FILE", "PACKAGE", "CURRENT", "EXPECTED", "ACTION")
    widths = [
        max(len(headers[index]), *(len(row[index]) for row in rows)) if rows else len(headers[index])
        for index in range(len(headers))
    ]
    print(
        "  ".join(
            header.ljust(widths[index]) for index, header in enumerate(headers)
        )
    )
    for row in rows:
        print(
            "  ".join(
                value.ljust(widths[index]) for index, value in enumerate(row)
            )
        )
    if not rows:
        print("No drift found.")


def print_regeneration_followup(drifts: list[Drift]) -> None:
    regenerate_drifts = [drift for drift in drifts if drift.action == "REGENERATE"]
    if not regenerate_drifts:
        return

    packages = ", ".join(
        f"{drift.package} {drift.current} -> {drift.expected}"
        for drift in regenerate_drifts
    )
    paths = ", ".join(sorted({display_path(drift.file) for drift in regenerate_drifts}))

    print("\nRegeneration follow-up suggested:")
    print(
        "Create a new Polaris bead/workstream to regenerate @polaris/fhir-de "
        f"generated output for: {packages}."
    )
    print(f"Generated provenance roots: {paths}")
    print("Expected follow-up workflow:")
    print("1. File and claim a Polaris bead for the regeneration work.")
    print("2. Work in a separate workstream/branch in ~/code/polaris.")
    print("3. Apply/update FHIR package pins before regenerating.")
    print("4. Run: bun run --cwd packages/fhir-de generate")
    print("5. Run: bun run --cwd packages/fhir-de check:deidentification")
    print("6. Fix generation/type/test issues and rerun the relevant Polaris checks.")
    print("7. Commit, pull --rebase or merge current main, push beads data, and git push.")


def npm_latest(package_name: str, registry: str) -> str | None:
    if shutil.which("npm") is None:
        return None
    result = subprocess.run(
        [
            "npm",
            "view",
            package_name,
            "dist-tags.latest",
            "--registry",
            registry,
            "--silent",
        ],
        capture_output=True,
        text=True,
        check=False,
        timeout=NPM_TIMEOUT_SECONDS,
    )
    if result.returncode != 0:
        return None
    latest = result.stdout.strip()
    return latest or None


def version_key(version: str) -> tuple[int, ...] | None:
    normalized = version.strip().lstrip("^~")
    match = re.match(r"^(\d+)(?:\.(\d+))?(?:\.(\d+))?", normalized)
    if not match:
        return None
    return tuple(int(part) for part in match.groups("0"))


def registry_is_behind(latest: str, expected: str) -> bool:
    if version_lt(latest, expected):
        return True
    latest_key = version_key(latest)
    expected_key = version_key(expected)
    if latest_key is None or expected_key is None:
        return latest != expected
    return False


def version_lt(a: str, b: str) -> bool:
    a_key = version_key(a)
    b_key = version_key(b)
    return a_key is not None and b_key is not None and a_key < b_key


def print_unpublished_report(expected_versions: dict[str, str], registry: str) -> None:
    if shutil.which("npm") is None:
        print("\nRegistry check skipped: npm not found on PATH.")
        return

    unpublished: list[tuple[str, str, str]] = []
    skipped = 0
    started_at = time.monotonic()
    for package_name, expected in sorted(expected_versions.items()):
        if time.monotonic() - started_at > REGISTRY_BUDGET_SECONDS:
            skipped += 1
            break
        try:
            latest = npm_latest(package_name, registry)
        except subprocess.TimeoutExpired:
            skipped += 1
            continue
        if latest is None:
            continue
        if registry_is_behind(latest, expected):
            unpublished.append((package_name, latest, expected))

    print("\nUnpublished packages:")
    if skipped:
        print(f"Registry check skipped {skipped} package(s): npm timed out.")
    if not unpublished:
        print("None detected.")
        return

    headers = ("PACKAGE", "REGISTRY", "MANIFEST")
    widths = [
        max(len(headers[index]), *(len(row[index]) for row in unpublished))
        for index in range(len(headers))
    ]
    print(
        "  ".join(
            header.ljust(widths[index]) for index, header in enumerate(headers)
        )
    )
    for row in unpublished:
        print(
            "  ".join(
                value.ljust(widths[index]) for index, value in enumerate(row)
            )
        )


def apply_package_json(path: Path, expected_versions: dict[str, str]) -> bool:
    with path.open(encoding="utf-8") as handle:
        data = json.load(handle)

    changed = False
    package_name = data.get("name")
    if package_name in expected_versions and data.get("version") != expected_versions[package_name]:
        data["version"] = expected_versions[package_name]
        changed = True

    for field in PACKAGE_JSON_DEPENDENCY_FIELDS:
        dependencies = data.get(field)
        if dependencies is None:
            continue
        if not isinstance(dependencies, dict):
            continue
        for package_name, expected in expected_versions.items():
            current = dependencies.get(package_name)
            if (
                package_name in dependencies
                and is_package_json_version_pin(current)
                and current != expected
            ):
                dependencies[package_name] = expected
                changed = True

    if changed:
        with path.open("w", encoding="utf-8") as handle:
            json.dump(data, handle, ensure_ascii=False, indent=2)
            handle.write("\n")
    return changed


def apply_sushi(path: Path, expected_versions: dict[str, str]) -> bool:
    lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
    changed = False
    in_dependencies = False
    dependency_indent: int | None = None

    for index, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            continue

        indent = len(line) - len(line.lstrip(" "))
        if stripped == "dependencies:":
            in_dependencies = True
            dependency_indent = None
            continue

        if in_dependencies:
            if indent == 0 and not line.startswith((" ", "\t")):
                break
            if dependency_indent is None and ":" in stripped:
                dependency_indent = indent
            if dependency_indent is not None and indent < dependency_indent:
                break
            match = re.match(
                r"^(?P<prefix>\s*)(?P<name>[^:#][^:]*):(?P<space>\s*)(?P<value>[^#\n]*?)(?P<suffix>\s*(?:#.*)?)(?P<newline>\r?\n?)$",
                line,
            )
            if not match:
                continue
            package_name = match.group("name").strip().strip("'\"")
            expected = expected_versions.get(package_name)
            if expected is None:
                continue
            current = match.group("value").strip().strip("'\"")
            if not current:
                for child_index in range(index + 1, len(lines)):
                    child_line = lines[child_index]
                    child_stripped = child_line.strip()
                    if not child_stripped or child_stripped.startswith("#"):
                        continue
                    child_indent = len(child_line) - len(child_line.lstrip(" "))
                    if child_indent <= indent:
                        break
                    if child_indent not in {indent + 2, indent + 4}:
                        continue
                    version_match = re.match(
                        r"^(?P<prefix>\s*)version:(?P<space>\s*)(?P<value>[^#\n]*?)(?P<suffix>\s*(?:#.*)?)(?P<newline>\r?\n?)$",
                        child_line,
                    )
                    if not version_match:
                        continue
                    child_current = version_match.group("value").strip().strip("'\"")
                    if child_current != expected:
                        lines[child_index] = (
                            f"{version_match.group('prefix')}version: "
                            f"{expected}{version_match.group('suffix')}{version_match.group('newline')}"
                        )
                        changed = True
                    break
                continue
            if current == expected:
                continue
            lines[index] = (
                f"{match.group('prefix')}{match.group('name')}: "
                f"{expected}{match.group('suffix')}{match.group('newline')}"
            )
            changed = True

    if changed:
        path.write_text("".join(lines), encoding="utf-8")
    return changed


def apply_drifts(consumers: list[ConsumerFile], manifest: dict[str, Any]) -> None:
    global_expected = build_effective_expected_versions(manifest, consumers)
    for consumer in consumers:
        expected_versions = expected_versions_for_consumer(
            manifest, consumer, global_expected
        )
        if consumer.kind == "sushi":
            apply_sushi(consumer.path, expected_versions)
        elif consumer.kind == "package-json":
            apply_package_json(consumer.path, expected_versions)


def run_drift_guard(repo_root: Path, manifest_path: Path) -> int:
    guard = repo_root / "scripts" / "check-fhir-version-drift.sh"
    if not guard.is_file():
        print(f"Drift guard not found: {guard}", file=sys.stderr)
        return 1
    result = subprocess.run(
        [str(guard), str(manifest_path), str(repo_root / "packages")],
        cwd=repo_root,
        check=False,
    )
    return result.returncode


def main() -> int:
    args = parse_args()
    manifest_path = find_manifest(args.manifest)
    repo_root = repo_root_from_manifest(manifest_path)
    manifest = load_yaml(manifest_path)
    consumers = discover_consumers(repo_root)
    drifts = compute_drifts(consumers, manifest, GENERATED_PROVENANCE_ROOTS)
    expected_versions = build_effective_expected_versions(manifest, consumers)

    print_drift_table(drifts)
    sys.stdout.flush()
    print_unpublished_report(expected_versions, args.registry)
    print_regeneration_followup(drifts)

    if args.apply:
        apply_drifts(consumers, manifest)
        guard_status = run_drift_guard(repo_root, manifest_path)
        if any(drift.action == "REGENERATE" for drift in drifts):
            return 1
        return guard_status

    return 1 if drifts else 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (FileNotFoundError, ValueError, yaml.YAMLError, json.JSONDecodeError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        raise SystemExit(2)
