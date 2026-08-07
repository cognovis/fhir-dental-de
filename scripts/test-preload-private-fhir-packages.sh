#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HELPER="$REPO_ROOT/scripts/preload-private-fhir-packages.sh"
TEMP_ROOT="$(mktemp -d)"

cleanup() {
  rm -rf "$TEMP_ROOT"
}
trap cleanup EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

test -x "$HELPER" || fail "$HELPER is not executable"

CONFIG="$TEMP_ROOT/sushi-config.yaml"
CACHE="$TEMP_ROOT/cache"
cat > "$CONFIG" <<'EOF'
id: example.dental
dependencies:
  hl7.fhir.r4.core: 4.0.1
  de.cognovis.terminology.dental.example: 2.0.0
  de.cognovis.fhir.praxis: 0.91.0
  de.cognovis.terminology.dental.another: 1.1.0
pages:
  index.md:
    title: Home
EOF

expected_dependencies=$'de.cognovis.terminology.dental.example\t2.0.0\nde.cognovis.fhir.praxis\t0.91.0\nde.cognovis.terminology.dental.another\t1.1.0'
actual_dependencies="$(bash "$HELPER" --list-private-dependencies "$CONFIG")"
test "$actual_dependencies" = "$expected_dependencies" || fail "private dependencies were not derived from sushi-config.yaml"

mkdir -p "$CACHE/de.cognovis.terminology.dental.example#2.0.0/package"
mkdir -p "$CACHE/de.cognovis.fhir.praxis#0.91.0/package"
touch "$CACHE/de.cognovis.terminology.dental.example#2.0.0/package/package.json"
touch "$CACHE/de.cognovis.fhir.praxis#0.91.0/package/package.json"

if bash "$HELPER" --verify-cache "$CONFIG" "$CACHE" >"$TEMP_ROOT/missing.log" 2>&1; then
  fail "a missing declared private package did not fail cache verification"
fi
grep -Fq "de.cognovis.terminology.dental.another#1.1.0" "$TEMP_ROOT/missing.log" || fail "missing package diagnostic was not emitted"

mkdir -p "$CACHE/de.cognovis.terminology.dental.another#1.1.0/package"
touch "$CACHE/de.cognovis.terminology.dental.another#1.1.0/package/package.json"
bash "$HELPER" --verify-cache "$CONFIG" "$CACHE"

DECLARED_CACHE="$TEMP_ROOT/declared-cache"
while IFS=$'\t' read -r package_name version; do
  mkdir -p "$DECLARED_CACHE/${package_name}#${version}/package"
  touch "$DECLARED_CACHE/${package_name}#${version}/package/package.json"
done < <(bash "$HELPER" --list-private-dependencies "$REPO_ROOT/sushi-config.yaml")
bash "$HELPER" --verify-cache "$REPO_ROOT/sushi-config.yaml" "$DECLARED_CACHE"

FETCH_CONFIG="$TEMP_ROOT/fetch-sushi-config.yaml"
FETCH_CACHE="$TEMP_ROOT/fetch-cache"
MOCK_NPM_LOG="$TEMP_ROOT/npm-inputs.log"
mkdir -p "$TEMP_ROOT/bin" "$TEMP_ROOT/home"
cat > "$FETCH_CONFIG" <<'EOF'
id: example.dental
dependencies:
  de.cognovis.terminology.dental.example: 2.0.0
  de.cognovis.terminology.dental.another: 1.0.0
EOF
cat > "$TEMP_ROOT/bin/npm" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

test "$1" = "pack"
package_spec="$2"
printf '%s\n' "$package_spec" >> "$MOCK_NPM_LOG"
mkdir package
case "$package_spec" in
  de.cognovis.terminology.dental.example@2.0.0)
    cat > package/package.json <<'PACKAGE'
{"dependencies":{"de.cognovis.terminology.dental.transitive":"1.0.0","hl7.fhir.r4.core":"4.0.1"}}
PACKAGE
    ;;
  de.cognovis.terminology.dental.transitive@1.0.0)
    printf '%s\n' '{"dependencies":{}}' > package/package.json
    ;;
  de.cognovis.terminology.dental.another@1.0.0)
    cat > package/package.json <<'PACKAGE'
{"dependencies":{"de.cognovis.terminology.dental.transitive":"1.0.0"}}
PACKAGE
    ;;
  *)
    echo "unexpected registry fetch: $package_spec" >&2
    exit 1
    ;;
esac
tar czf "$(printf '%s' "$package_spec" | tr '@/' '--').tgz" package
EOF
chmod +x "$TEMP_ROOT/bin/npm"

HOME="$TEMP_ROOT/home" \
VERDACCIO_TOKEN=fixture-token \
FHIR_PACKAGES_DIR="$FETCH_CACHE" \
MOCK_NPM_LOG="$MOCK_NPM_LOG" \
PATH="$TEMP_ROOT/bin:$PATH" \
bash "$HELPER" "$FETCH_CONFIG"
grep -Fxq 'de.cognovis.terminology.dental.example@2.0.0' "$MOCK_NPM_LOG" || fail "declared private package was not fetched"
grep -Fxq 'de.cognovis.terminology.dental.another@1.0.0' "$MOCK_NPM_LOG" || fail "second declared private package was not fetched"
grep -Fxq 'de.cognovis.terminology.dental.transitive@1.0.0' "$MOCK_NPM_LOG" || fail "private transitive package was not fetched"
if grep -Fq 'hl7.fhir.r4.core@4.0.1' "$MOCK_NPM_LOG"; then
  fail "public transitive package was fetched from the private registry"
fi

echo "private FHIR package preload tests passed"
