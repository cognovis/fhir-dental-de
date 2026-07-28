#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOOK="$REPO_ROOT/.githooks/pre-push"
TEMP_ROOT="$(mktemp -d)"
INPUT_LINE="refs/heads/test 1111111111111111111111111111111111111111 refs/heads/test 0000000000000000000000000000000000000000"
trap 'rm -rf "$TEMP_ROOT"' EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

run_hook() {
  local output_file="$1"
  shift
  set +e
  printf '%s\n' "$INPUT_LINE" |
    env FIXTURE_ROOT="$TEMP_ROOT" PATH="$TEMP_ROOT/bin:$PATH" "$@" \
      "$TEMP_ROOT/.githooks/pre-push" origin fixture-url >"$output_file" 2>&1
  local status=$?
  set -e
  return "$status"
}

write_passing_guard() {
  local path="$1"
  local label="$2"
  cat >"$path" <<EOF
#!/usr/bin/env bash
echo "fixture $label passed"
EOF
  chmod +x "$path"
}

[ -x "$HOOK" ] || fail "$HOOK is not executable"
mkdir -p "$TEMP_ROOT/.githooks" "$TEMP_ROOT/scripts" "$TEMP_ROOT/bin"
cp -f "$HOOK" "$TEMP_ROOT/.githooks/pre-push"

cat >"$TEMP_ROOT/bin/bd" <<'EOF'
#!/usr/bin/env bash
cat >"$FIXTURE_ROOT/bd-input.txt"
EOF
chmod +x "$TEMP_ROOT/bin/bd"

cat >"$TEMP_ROOT/scripts/check-sushi.sh" <<'EOF'
#!/usr/bin/env bash
cat >"$FIXTURE_ROOT/sushi-input.txt"
EOF
chmod +x "$TEMP_ROOT/scripts/check-sushi.sh"

missing_output="$TEMP_ROOT/missing-output.txt"
if run_hook "$missing_output"; then
  fail "missing vendor guard did not block"
else
  missing_status=$?
fi
[ "$missing_status" -eq 2 ] || fail "missing vendor guard returned $missing_status instead of 2"
grep -q "missing or not executable" "$missing_output" || fail "missing-guard diagnostic was not preserved"

write_passing_guard "$TEMP_ROOT/scripts/vendor-leak-guard.sh" "vendor guard"
write_passing_guard "$TEMP_ROOT/scripts/check-copyright.sh" "copyright guard"

pass_output="$TEMP_ROOT/pass-output.txt"
run_hook "$pass_output" || fail "passing hook chain blocked"
grep -q "fixture vendor guard passed" "$pass_output" || fail "vendor-guard output was not preserved"
grep -q "fixture copyright guard passed" "$pass_output" || fail "copyright-guard output was not preserved"
grep -qxF "$INPUT_LINE" "$TEMP_ROOT/bd-input.txt" || fail "beads hook did not receive pre-push input"
grep -qxF "$INPUT_LINE" "$TEMP_ROOT/sushi-input.txt" || fail "SUSHI hook did not receive pre-push input"

cat >"$TEMP_ROOT/scripts/vendor-leak-guard.sh" <<'EOF'
#!/usr/bin/env bash
echo "fixture vendor finding" >&2
exit 1
EOF
chmod +x "$TEMP_ROOT/scripts/vendor-leak-guard.sh"

vendor_output="$TEMP_ROOT/vendor-output.txt"
if run_hook "$vendor_output"; then
  fail "failing vendor guard did not block"
else
  vendor_status=$?
fi
[ "$vendor_status" -eq 2 ] || fail "failing vendor guard returned $vendor_status instead of 2"
grep -q "fixture vendor finding" "$vendor_output" || fail "vendor diagnostic was not preserved"
grep -q "push blocked" "$vendor_output" || fail "blocking diagnostic was not emitted"

write_passing_guard "$TEMP_ROOT/scripts/vendor-leak-guard.sh" "vendor guard"
cat >"$TEMP_ROOT/scripts/check-copyright.sh" <<'EOF'
#!/usr/bin/env bash
echo "fixture copyright finding" >&2
exit 1
EOF
chmod +x "$TEMP_ROOT/scripts/check-copyright.sh"

copyright_output="$TEMP_ROOT/copyright-output.txt"
if run_hook "$copyright_output"; then
  fail "failing copyright guard did not block"
else
  copyright_status=$?
fi
[ "$copyright_status" -eq 2 ] || fail "failing copyright guard returned $copyright_status instead of 2"
grep -q "fixture copyright finding" "$copyright_output" || fail "copyright diagnostic was not preserved"

rm -f "$TEMP_ROOT/scripts/check-copyright.sh"
skip_output="$TEMP_ROOT/skip-output.txt"
run_hook "$skip_output" SKIP_COPYRIGHT_CHECK=1 || fail "copyright bypass required the skipped guard"
grep -q "copyright check skipped" "$skip_output" || fail "copyright bypass diagnostic was not emitted"

echo "pre-push vendor-guard tests passed"
