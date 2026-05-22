#!/usr/bin/env python3
"""Generate FHIR snapshots for kbv.basis StructureDefinitions in the local cache.

KBV publishes kbv.basis WITHOUT snapshots. SUSHI and the IG Publisher require a
snapshot when a profile (or example) inherits from a KBV_PR_Base_* profile, so a
fresh `sushi .` fails with "... is missing a snapshot. Snapshot is required for
import." until the snapshots are injected into the package cache.

This is the LOCAL equivalent of the CI-only composite action at
`.github/actions/generate-kbv-basis-snapshots/action.yml`. Keep them in sync.

Requires: java on PATH (brew install openjdk). Idempotent: if every kbv.basis SD
already has a snapshot, it downloads nothing and exits 0 immediately.
"""
import glob
import json
import os
import subprocess
import sys
import time
import urllib.request

VALIDATOR_JAR = "/tmp/validator_cli.jar"
# Pinned to match the CI action. To bump: change here and in action.yml, test locally.
VALIDATOR_URL = "https://github.com/hapifhir/org.hl7.fhir.core/releases/download/6.9.7/validator_cli.jar"
FHIR_PACKAGES_DIR = os.path.expanduser("~/.fhir/packages")


def find_kbv_basis_versions():
    versions = []
    for d in sorted(glob.glob(os.path.join(FHIR_PACKAGES_DIR, "kbv.basis#*"))):
        pkg_dir = os.path.join(d, "package")
        if os.path.isdir(pkg_dir):
            versions.append((os.path.basename(d), pkg_dir))
    return versions


def count_snapshots(pkg_dir):
    all_json = glob.glob(os.path.join(pkg_dir, "StructureDefinition-*.json"))
    sds = sorted(f for f in all_json if not f.endswith(".snapshot.json"))
    with_snapshot = 0
    for f in sds:
        try:
            with open(f) as fh:
                data = json.load(fh)
            if data.get("snapshot", {}).get("element"):
                with_snapshot += 1
        except (json.JSONDecodeError, OSError):
            pass
    return sds, with_snapshot


def ensure_validator_jar():
    if os.path.exists(VALIDATOR_JAR) and os.path.getsize(VALIDATOR_JAR) > 10_000_000:
        print(f"  validator_cli.jar already cached at {VALIDATOR_JAR}")
        return
    print("  Downloading HL7 FHIR Validator CLI (~150MB) ...")
    dl_start = time.time()
    urllib.request.urlretrieve(VALIDATOR_URL, VALIDATOR_JAR)
    size_mb = os.path.getsize(VALIDATOR_JAR) / 1024 / 1024
    print(f"  Downloaded {size_mb:.0f}MB in {time.time() - dl_start:.1f}s")


def generate_snapshots_for_version(version_dir, pkg_dir, sds):
    print("  Running HL7 FHIR Validator CLI snapshot generation ...")
    kbv_version = version_dir.split("#", 1)[1]
    cmd = [
        "java", "-jar", VALIDATOR_JAR, "snapshot",
        "-version", "4.0.1",
        "-ig", "de.basisprofil.r4#1.6.0-ballot2",  # upstream base profiles
        "-ig", f"kbv.basis#{kbv_version}",           # internal cross-refs
    ] + sds + ["-outputSuffix", "snapshot.json"]
    snap_start = time.time()
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=600)
    if result.returncode != 0:
        print(f"  ERROR: Validator exited with code {result.returncode}")
        print(result.stderr[-2000:])
        sys.exit(1)
    elapsed = time.time() - snap_start
    print(f"  Validator completed in {elapsed:.1f}s")
    return elapsed


def merge_snapshots_back(sds):
    merged, errors = 0, 0
    for sd_file in sds:
        snap_file = sd_file + ".snapshot.json"
        if not os.path.exists(snap_file):
            print(f"  WARNING: No snapshot generated for {os.path.basename(sd_file)}")
            errors += 1
            continue
        try:
            with open(snap_file) as fh:
                snap_data = json.load(fh)
            with open(sd_file) as fh:
                orig_data = json.load(fh)
            orig_data["snapshot"] = snap_data.get("snapshot", {})
            with open(sd_file, "w") as f:
                json.dump(orig_data, f, indent=2)
            open(snap_file, "w").close()  # truncate temp (avoids permission issues)
            merged += 1
        except (json.JSONDecodeError, OSError) as e:
            print(f"  ERROR merging {os.path.basename(sd_file)}: {e}")
            errors += 1
    return merged, errors


def main():
    kbv_versions = find_kbv_basis_versions()
    if not kbv_versions:
        print("No kbv.basis packages in ~/.fhir/packages — run `sushi .` once to "
              "download it (or it will be fetched on the next build).")
        return 0

    any_work = False
    for version_dir, pkg_dir in kbv_versions:
        sds, with_snapshot = count_snapshots(pkg_dir)
        total = len(sds)
        if total == 0:
            continue
        if with_snapshot == total:
            print(f"{version_dir}: all {total} snapshots present — skipping (idempotent)")
            continue
        print(f"{version_dir}: {total - with_snapshot}/{total} SDs missing snapshots — generating ...")
        any_work = True
        ensure_validator_jar()
        generate_snapshots_for_version(version_dir, pkg_dir, sds)
        merged, errors = merge_snapshots_back(sds)
        if errors:
            print(f"  ERROR: {errors} SDs failed to merge — aborting")
            return 1
        _, after = count_snapshots(pkg_dir)
        if after != total:
            print(f"  ERROR: expected {total} snapshots, got {after}")
            return 1
        print(f"  Generated and merged {merged} snapshots for {version_dir}")

    if not any_work:
        print("All kbv.basis snapshots already present — nothing to do.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
