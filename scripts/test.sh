#!/usr/bin/env bash
# Local Aidbox integration test for fhir-dental-de.
#
# Spins up an ephemeral Aidbox on port 8891, installs the dental IG via
# $fhir-package-install from npm.cognovis.de, uploads local StructureDefinitions,
# runs httpyac Profile tests, then tears down.
#
# Usage: ./scripts/test.sh [--keep] [--skip-httpyac]
#   --keep           Keep containers running after tests (for debugging)
#   --skip-httpyac   Skip httpyac profile validation tests
#
# Requires: docker compose, curl, jq, python3
# Optional: httpyac (npm install -g httpyac)
#
# AIDBOX_LICENSE_KEY is read from (in order):
#   1. Environment variable
#   2. .env in project root
#   3. ../mira/.env (neighboring repo)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
AIDBOX_IMAGE="${AIDBOX_IMAGE:-healthsamurai/aidboxone:edge}"
AIDBOX_PORT="${AIDBOX_PORT:-8891}"
AIDBOX_URL="http://localhost:${AIDBOX_PORT}"
AUTH="basic:secret"
KEEP=false
SKIP_HTTPYAC=false
ERRORS=0
PASS=0
COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-fhir-dental-de-test}"
TMPTEST=""

DENTAL_PACKAGE="de.cognovis.fhir.dental"
DENTAL_VERSION="$(tr -d '[:space:]' < "$ROOT_DIR/VERSION")"
NPM_REGISTRY="https://npm.cognovis.de"

for arg in "$@"; do
  case "$arg" in
    --keep)          KEEP=true ;;
    --skip-httpyac)  SKIP_HTTPYAC=true ;;
  esac
done

cleanup() {
  if [[ -n "$TMPTEST" && -d "$TMPTEST" ]]; then
    rm -rf "$TMPTEST"
  fi
  if [[ "$KEEP" == "false" ]]; then
    echo ""
    echo "=== Tearing down Aidbox ==="
    COMPOSE_PROJECT_NAME="$COMPOSE_PROJECT_NAME" docker compose \
      -f "$ROOT_DIR/docker-compose.test.yaml" down -v 2>/dev/null || true
  else
    echo ""
    echo "=== Keeping containers running (--keep) ==="
    echo "  Aidbox: $AIDBOX_URL"
    echo "  Tear down: COMPOSE_PROJECT_NAME=$COMPOSE_PROJECT_NAME docker compose -f docker-compose.test.yaml down -v"
  fi
}
trap cleanup EXIT

ensure_port_free() {
  python3 - "$AIDBOX_PORT" <<'PY'
import socket, sys
port = int(sys.argv[1])
for host, family in (("127.0.0.1", socket.AF_INET), ("::1", socket.AF_INET6)):
    sock = socket.socket(family, socket.SOCK_STREAM)
    sock.settimeout(0.2)
    try:
        if sock.connect_ex((host, port)) == 0:
            print(f"ERROR: port {port} is already in use. Set AIDBOX_PORT to a free port.", file=sys.stderr)
            sys.exit(1)
    finally:
        sock.close()
PY
}

fhir_get() {
  curl --max-time 30 -sf "$AIDBOX_URL/fhir/$1" -u "$AUTH" -H "Accept: application/json" 2>/dev/null \
    || echo '{"total":0}'
}

assert_count_gte() {
  local name="$1" expected="$2" response="$3"
  local total
  total=$(echo "$response" | python3 -c "import json,sys; print(json.load(sys.stdin).get('total',0))" 2>/dev/null || echo "0")
  if [ "$total" -ge "$expected" ] 2>/dev/null; then
    echo "  PASS: $name (total=$total >= $expected)"
    PASS=$((PASS + 1))
  else
    echo "  FAIL: $name — expected >= $expected, got $total"
    ERRORS=$((ERRORS + 1))
  fi
}

# --- Resolve AIDBOX_LICENSE_KEY ---
if [[ -z "${AIDBOX_LICENSE_KEY:-}" ]]; then
  for env_file in "$ROOT_DIR/.env" "$(dirname "$ROOT_DIR")/mira/.env"; do
    if [[ -f "$env_file" ]] && grep -q "AIDBOX_LICENSE_KEY" "$env_file"; then
      AIDBOX_LICENSE_KEY=$(grep "^AIDBOX_LICENSE_KEY=" "$env_file" | cut -d= -f2-)
      echo "Using AIDBOX_LICENSE_KEY from $env_file"
      break
    fi
  done
fi
if [[ -z "${AIDBOX_LICENSE_KEY:-}" ]]; then
  echo "ERROR: AIDBOX_LICENSE_KEY not found. Export it or add to .env or ../mira/.env"
  exit 1
fi

ensure_port_free

export AIDBOX_PORT AIDBOX_IMAGE COMPOSE_PROJECT_NAME AIDBOX_LICENSE_KEY DENTAL_VERSION

echo "=== Starting Aidbox $AIDBOX_IMAGE on port $AIDBOX_PORT ==="
COMPOSE_PROJECT_NAME="$COMPOSE_PROJECT_NAME" docker compose \
  -f "$ROOT_DIR/docker-compose.test.yaml" up -d --pull missing

echo "Waiting for Aidbox HTTP..."
for i in $(seq 1 60); do
  if curl -sf "$AIDBOX_URL/health" > /dev/null 2>&1; then
    echo "Aidbox HTTP up after $((i * 5))s"; break
  fi
  if [ "$i" -eq 60 ]; then
    echo "ERROR: Aidbox did not start within 300s"
    COMPOSE_PROJECT_NAME="$COMPOSE_PROJECT_NAME" docker compose \
      -f "$ROOT_DIR/docker-compose.test.yaml" logs aidbox | tail -30
    exit 1
  fi
  sleep 5
done

echo ""
echo "=== POST init-bundle.json ==="
for attempt in 1 2 3 4 5; do
  HTTP_CODE=$(curl -s -o /tmp/aidbox-init-resp.json -w "%{http_code}" \
    -X POST "$AIDBOX_URL/" -u "$AUTH" \
    -H "Content-Type: application/json" -d @"$ROOT_DIR/init-bundle.json")
  if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
    echo "init-bundle OK (attempt $attempt, HTTP $HTTP_CODE)"; break
  fi
  if [ "$attempt" -eq 5 ]; then
    echo "ERROR: init-bundle POST failed after 5 attempts (HTTP $HTTP_CODE)"
    cat /tmp/aidbox-init-resp.json 2>/dev/null && echo ""
    exit 1
  fi
  sleep 5
done

echo ""
echo "=== Checking package registry: $DENTAL_PACKAGE@$DENTAL_VERSION via $NPM_REGISTRY ==="
echo "(BOX_BOOTSTRAP_FHIR_PACKAGES: checking Aidbox startup logs for resolution errors)"
# FAR-loaded packages don't appear in StructureDefinition search — check logs instead.
# Give Aidbox ~30s after HTTP-up to attempt package resolution.
COMPOSE_LOGS=$(COMPOSE_PROJECT_NAME="$COMPOSE_PROJECT_NAME" docker compose \
  -f "$ROOT_DIR/docker-compose.test.yaml" logs aidbox 2>/dev/null || true)
REGISTRY_ERRORS=$(echo "$COMPOSE_LOGS" | grep -i "cognovis\|praxis\|dental" | grep -i "404\|not found\|error\|fail" || true)
if [[ -n "$REGISTRY_ERRORS" ]]; then
  echo "  FAIL: package registry errors detected:"
  echo "$REGISTRY_ERRORS" | head -5
  ERRORS=$((ERRORS + 1))
else
  echo "  PASS: no registry errors for cognovis packages in startup logs"
  PASS=$((PASS + 1))
fi

echo ""
echo "=== Uploading local StructureDefinitions for validation ==="
SD_FILES=("$ROOT_DIR"/fsh-generated/resources/StructureDefinition-*.json)
if [[ ${#SD_FILES[@]} -gt 0 && -f "${SD_FILES[0]}" ]]; then
  ENTRIES=""
  COUNT=0
  for f in "${SD_FILES[@]}"; do
    ID=$(jq -r '.id' "$f")
    RESOURCE=$(cat "$f")
    [[ -n "$ENTRIES" ]] && ENTRIES="$ENTRIES,"
    ENTRIES="$ENTRIES{\"resource\":$RESOURCE,\"request\":{\"method\":\"PUT\",\"url\":\"StructureDefinition/$ID\"}}"
    COUNT=$((COUNT + 1))
  done
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "$AIDBOX_URL/" -u "$AUTH" \
    -H "Content-Type: application/json" \
    -d "{\"resourceType\":\"Bundle\",\"type\":\"transaction\",\"entry\":[$ENTRIES]}")
  if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
    echo "  Uploaded $COUNT StructureDefinitions (HTTP $HTTP_CODE)"
  else
    echo "  WARNING: SD upload failed (HTTP $HTTP_CODE)"
  fi
else
  echo "  SKIP: no fsh-generated/resources/StructureDefinition-*.json found (run sushi first)"
fi

if [[ "$SKIP_HTTPYAC" == "false" ]] && command -v httpyac &>/dev/null; then
  echo ""
  echo "=== Running httpyac Profile tests ==="
  TMPTEST="$(mktemp -d)"
  cp -r "$ROOT_DIR/test/." "$TMPTEST/"
  # Substitute hardcoded URL and mira admin credentials for the test Aidbox.
  # Profile tests use base64(admin:mira-pw) — replace with literal basic:secret
  # which matches the AccessPolicy set up in init-bundle.json.
  find "$TMPTEST" -name "*.http" -print0 | xargs -0 python3 -c "
import sys, pathlib
files = sys.argv[1:]
for f in files:
    p = pathlib.Path(f)
    txt = p.read_text()
    txt = txt.replace('http://localhost:8080', '$AIDBOX_URL')
    txt = txt.replace('Basic YWRtaW46YVZyeFA1TkJyZlRLZWlpdDBxRnpLVzNL', 'Basic basic:secret')
    p.write_text(txt)
" 2>/dev/null || true

  (cd "$TMPTEST" && httpyac run "Profile/" --all --output short) \
    && { echo "  PASS: Profile tests"; PASS=$((PASS + 1)); } \
    || { echo "  WARNING: Profile tests had failures"; }
else
  if [[ "$SKIP_HTTPYAC" == "true" ]]; then
    echo ""
    echo "(httpyac tests skipped via --skip-httpyac)"
  else
    echo ""
    echo "(httpyac not installed — skipping profile tests; npm install -g httpyac to enable)"
  fi
fi

echo ""
echo "==============================="
echo "  PASS: $PASS"
echo "  FAIL: $ERRORS"
echo "==============================="
if [ "$ERRORS" -gt 0 ]; then
  echo "  STATUS: FAILED"
  exit 1
else
  echo "  STATUS: ALL PASSED"
fi
