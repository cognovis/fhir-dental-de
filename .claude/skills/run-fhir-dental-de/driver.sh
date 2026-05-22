#!/usr/bin/env bash
# driver.sh — build + smoke-test the fhir-dental-de Implementation Guide.
#
# This is the agent-facing way to "run" this project. There is no GUI and no
# long-running server: the deliverable is FHIR JSON compiled from FSH by SUSHI,
# which CI then feeds to the IG Publisher. This driver reproduces the part of
# the CI pipeline that runs locally and is verifiable without Docker:
#
#   1. prefetch the private de.cognovis.fhir.praxis dependency into ~/.fhir
#   2. inject snapshots into the kbv.basis package cache (needs Java)
#   3. run `sushi .`
#   4. assert the build is clean (0 errors) and emit a resource-count summary
#
# Exit 0: clean SUSHI build. Exit 1: errors, a crash, or missing prerequisites.
#
# Usage:
#   .claude/skills/run-fhir-dental-de/driver.sh            # full build + smoke check
#   SKIP_SNAPSHOTS=1 .claude/skills/run-fhir-dental-de/driver.sh   # skip step 2 (re-runs)
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_ROOT"

# openjdk is keg-only on macOS; put it on PATH so the validator (and IG Publisher)
# can find `java`. Harmless on Linux/CI where java is already resolvable.
[ -d /opt/homebrew/opt/openjdk/bin ] && export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

step() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }
fail() { printf '\033[1;31m✗ %s\033[0m\n' "$*" >&2; exit 1; }

# ---- 1. praxis dependency ------------------------------------------------
step "1/4  Prefetching de.cognovis.fhir.praxis (private dep)"
if ls ~/.fhir/packages/de.cognovis.fhir.praxis#* >/dev/null 2>&1; then
  echo "    already in ~/.fhir/packages — skipping"
else
  ./scripts/prefetch-praxis.sh || fail "prefetch-praxis.sh failed (check gh/network access to cognovis/fhir-praxis-de releases)"
fi

# ---- 2. kbv.basis snapshots ---------------------------------------------
if [ "${SKIP_SNAPSHOTS:-0}" = "1" ]; then
  step "2/4  Skipping kbv.basis snapshot generation (SKIP_SNAPSHOTS=1)"
else
  step "2/4  Generating kbv.basis snapshots (Java validator)"
  command -v java >/dev/null 2>&1 || fail "java not found — install with: brew install openjdk"
  python3 "$SKILL_DIR/gen-kbv-snapshots.py" || fail "kbv.basis snapshot generation failed"
fi

# ---- 3. SUSHI ------------------------------------------------------------
step "3/4  Compiling FSH -> FHIR JSON (sushi .)"
if command -v sushi >/dev/null 2>&1; then
  SUSHI=(sushi)
else
  echo "    sushi not on PATH — using npx fsh-sushi"
  SUSHI=(npx --yes fsh-sushi@latest)
fi
SUSHI_LOG="$(mktemp)"
trap 'rm -f "$SUSHI_LOG"' EXIT
"${SUSHI[@]}" . 2>&1 | tee "$SUSHI_LOG"

# ---- 4. assert + summarize ----------------------------------------------
step "4/4  Smoke check"
ERRORS="$(grep -oE '[0-9]+ Errors' "$SUSHI_LOG" | tail -1 | awk '{print $1}')"
WARNINGS="$(grep -oE '[0-9]+ Warnings' "$SUSHI_LOG" | tail -1 | awk '{print $1}')"
RES_DIR="$REPO_ROOT/fsh-generated/resources"
[ -d "$RES_DIR" ] || fail "no fsh-generated/resources — SUSHI did not emit output"
RES_COUNT="$(ls "$RES_DIR"/*.json 2>/dev/null | wc -l | tr -d ' ')"
IG_JSON="$RES_DIR/ImplementationGuide-de.cognovis.fhir.dental.json"
[ -f "$IG_JSON" ] || fail "ImplementationGuide resource not generated"

echo "    sushi: ${ERRORS:-?} errors, ${WARNINGS:-?} warnings"
echo "    fsh-generated/resources: $RES_COUNT JSON files"
echo "    ImplementationGuide-de.cognovis.fhir.dental.json present ✓"

if [ "${ERRORS:-1}" != "0" ]; then
  echo ""
  grep -E '^error' "$SUSHI_LOG" | head -10
  fail "SUSHI reported ${ERRORS:-?} errors (see above). If they are all 'missing a snapshot' for KBV_PR_Base_*, re-run WITHOUT SKIP_SNAPSHOTS."
fi
printf '\n\033[1;32m✓ Build clean: %s resources, 0 errors, %s warnings\033[0m\n' "$RES_COUNT" "${WARNINGS:-0}"
