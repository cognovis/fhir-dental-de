#!/bin/bash
# Build a FHIR npm package from SUSHI output.
# Creates dist/package/ with package.json + all StructureDefinition/CodeSystem/ValueSet JSONs.
# Usage: ./scripts/build-package.sh
#        Then: cd dist && npm pack  (creates .tgz for npm install)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$SCRIPT_DIR/.."
DIST="$ROOT/dist/package"
SKIP_SUSHI=false

if [[ "${1:-}" == "--skip-sushi" ]]; then
  SKIP_SUSHI=true
fi

# 1. Read version from VERSION file (single source of truth)
VERSION=$(tr -d '[:space:]' < "$ROOT/VERSION")
PACKAGE_ID=$(grep '^id:' "$ROOT/sushi-config.yaml" | awk '{print $2}')

# 2. (Intentionally skipped — version sync enforced by CI step before SUSHI runs)

# 3. Run SUSHI (unless --skip-sushi, e.g. when called after IG Publisher)
if [ "$SKIP_SUSHI" = false ]; then
  echo "Running SUSHI..."
  cd "$ROOT"
  npx sushi . 2>&1 | tail -5
else
  echo "Skipping SUSHI (--skip-sushi)"
  cd "$ROOT"
fi
echo "Building $PACKAGE_ID@$VERSION"

# 3. Create dist/package/ directory
rm -rf "$DIST"
mkdir -p "$DIST"

# 4. Create package.json (FHIR package format)
cat > "$DIST/package.json" <<EOF
{
  "name": "$PACKAGE_ID",
  "version": "$VERSION",
  "description": "German Dental FHIR Profiles (R4)",
  "author": "cognovis GmbH",
  "fhirVersions": ["4.0.1"],
  "jurisdiction": "urn:iso:std:iso:3166#DE",
  "canonical": "https://fhir.cognovis.de/dental",
  "url": "https://fhir.cognovis.de/dental/ImplementationGuide/de.cognovis.fhir.dental",
  "dependencies": {
    "hl7.fhir.r4.core": "4.0.1",
    "de.basisprofil.r4": "1.5.0",
    "kbv.basis": "1.7.0",
    "kbv.ita.for": "1.3.1",
    "de.gematik.fhir.atf": "1.4.1"
  }
}
EOF

# 5. Copy all StructureDefinition, CodeSystem, ValueSet JSONs (flat, like KBV packages)
#    Prefer IG Publisher output (has snapshots) over raw SUSHI output (differentials only).
#    Downstream consumers (e.g. mira-adapters) need snapshots for import.
if [ -d "$ROOT/output" ] && ls "$ROOT/output/"StructureDefinition-*.json &>/dev/null; then
  RESOURCE_DIR="$ROOT/output"
  echo "Using IG Publisher output (with snapshots)"
else
  RESOURCE_DIR="$ROOT/fsh-generated/resources"
  echo "Warning: Using SUSHI output (no snapshots) — run IG Publisher first for full packages"
fi

for f in "$RESOURCE_DIR/"*.json; do
  basename=$(basename "$f")
  # Skip ImplementationGuide resource itself
  if [[ "$basename" == ImplementationGuide-* ]]; then
    continue
  fi
  cp "$f" "$DIST/$basename"
done

# 5b. Copy pre-built JSON resources from input/resources/ (e.g., external CodeSystems)
# Note: Aidbox $fhir-package-install skips resources with external canonical URLs.
# External CodeSystems (e.g., ex-tooth) must be PUT directly after package install.
if [ -d "$ROOT/input/resources" ]; then
  for f in "$ROOT/input/resources/"*.json; do
    [ -f "$f" ] || continue
    cp "$f" "$DIST/$(basename "$f")"
  done
fi

COUNT=$(ls "$DIST"/*.json | wc -l | tr -d ' ')
echo "Package dir: $DIST ($COUNT resources)"

# 6. Create tgz
cd "$DIST"
npm pack --pack-destination "$ROOT/dist"
cd "$ROOT"

TGZ="dist/${PACKAGE_ID}-${VERSION}.tgz"
echo "Package built: $TGZ ($(du -h "$TGZ" | cut -f1))"
