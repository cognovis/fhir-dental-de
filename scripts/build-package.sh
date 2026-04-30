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

# 2. Sync version into sushi-config.yaml before SUSHI runs
#    (CI also enforces this via "Verify version sync" step, but local builds need it too)
if [[ "$(uname)" == "Darwin" ]]; then
  sed -i '' "s/^version: .*/version: $VERSION/" "$ROOT/sushi-config.yaml"
else
  sed -i "s/^version: .*/version: $VERSION/" "$ROOT/sushi-config.yaml"
fi

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

# 4. Create dist/package/ directory
rm -rf "$DIST"
mkdir -p "$DIST"

# 5. Create package.json (FHIR package format) — deps derived from sushi-config.yaml
DEPS_JSON=$(python3 - "$ROOT" <<'PYEOF'
import re, json, sys

root = sys.argv[1]
with open(f"{root}/sushi-config.yaml") as f:
    content = f.read()

match = re.search(r'^dependencies:\s*\n((?:  \S.*\n)*)', content, re.MULTILINE)
deps = {"hl7.fhir.r4.core": "4.0.1"}
if match:
    for line in match.group(1).splitlines():
        line = line.strip().split("#")[0].strip()
        if ":" in line:
            k, v = line.split(":", 1)
            deps[k.strip()] = v.strip()
if len(deps) <= 1:
    print("WARNING: No dependencies extracted from sushi-config.yaml — check indentation", file=sys.stderr)
print(json.dumps(deps, indent=4))
PYEOF
)

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
  "dependencies": $DEPS_JSON
}
EOF

# 6. Copy all StructureDefinition, CodeSystem, ValueSet JSONs (flat, like KBV packages)
#    Prefer IG Publisher output (has snapshots) over raw SUSHI output (differentials only).
#    Downstream consumers (e.g. downstream FHIR consumers) need snapshots for import.
if [ -d "$ROOT/output" ] && ls "$ROOT/output/"StructureDefinition-*.json &>/dev/null; then
  RESOURCE_DIR="$ROOT/output"
  echo "Using IG Publisher output (with snapshots)"
else
  RESOURCE_DIR="$ROOT/fsh-generated/resources"
  echo "Warning: Using SUSHI output (no snapshots) — run IG Publisher first for full packages"
fi

for f in "$RESOURCE_DIR/"*.json; do
  basename=$(basename "$f")
  # Only include conformance resources (skip ImplementationGuide, examples, CapabilityStatements, etc.)
  case "$basename" in
    StructureDefinition-*|CodeSystem-*|ValueSet-*|NamingSystem-*|SearchParameter-*)
      cp "$f" "$DIST/$basename"
      ;;
  esac
done

# 6b. Copy pre-built JSON resources from input/resources/ (e.g., external CodeSystems)
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

# 7. Create tgz
cd "$DIST"
npm pack --pack-destination "$ROOT/dist"
cd "$ROOT"

TGZ="dist/${PACKAGE_ID}-${VERSION}.tgz"
echo "Package built: $TGZ ($(du -h "$TGZ" | cut -f1))"
