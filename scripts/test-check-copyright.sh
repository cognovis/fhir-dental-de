#!/usr/bin/env bash
# scripts/test-check-copyright.sh
#
# Self-tests for check-copyright.sh.
# Tests: violation detection, path allowlist, inline allowlist marker.
#
# Exit 0: all tests pass. Exit 1: one or more tests failed.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPT="$REPO_ROOT/scripts/check-copyright.sh"

# --- Temp file management ---
TMPFILES=()
cleanup() {
  for f in "${TMPFILES[@]}"; do
    rm -f "$f"
  done
}
trap cleanup EXIT

make_tempfile() {
  local path="$1"
  local dir
  dir="$(dirname "$REPO_ROOT/$path")"
  mkdir -p "$dir"
  TMPFILES+=("$REPO_ROOT/$path")
  printf '%s\n' "$2" > "$REPO_ROOT/$path"
  echo "$path"
}

# --- Test harness ---
PASS=0
FAIL=0

run_test() {
  local name="$1"
  local expected_exit="$2"
  shift 2
  local actual_exit=0
  bash "$SCRIPT" "$@" >/dev/null 2>&1 || actual_exit=$?
  if [ "$actual_exit" -eq "$expected_exit" ]; then
    echo "PASS: $name"
    PASS=$(( PASS + 1 ))
  else
    echo "FAIL: $name (expected exit $expected_exit, got $actual_exit)"
    FAIL=$(( FAIL + 1 ))
  fi
}

# --- Test 1: Strict path with blocklisted string → exit 1 ---
VIOLATION_FILE="input/fsh/test-violation.fsh"
make_tempfile "$VIOLATION_FILE" "// Vollgusskrone NEM" >/dev/null
run_test "blocklisted string in strict path exits 1" 1 -- "$VIOLATION_FILE"

# --- Test 2: Allowlisted path with same string → exit 0 ---
ALLOWLIST_FILE="docs/adr/test-discussion.md"
make_tempfile "$ALLOWLIST_FILE" "Vollgusskrone NEM is a copyrighted term" >/dev/null
run_test "blocklisted string in allowlisted path exits 0" 0 -- "$ALLOWLIST_FILE"

# --- Test 3: Inline allowlist marker → exit 0 ---
INLINE_FILE="input/fsh/test-inline.fsh"
make_tempfile "$INLINE_FILE" "// Vollgusskrone NEM # copyright-allowlist: test" >/dev/null
run_test "inline copyright-allowlist marker exits 0" 0 -- "$INLINE_FILE"

# --- Summary ---
echo ""
echo "Results: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
exit 0
