#!/usr/bin/env bash
# vendor-leak-guard.sh — Scans for vendor-specific strings that must not appear in public content.
#
# Usage:
#   ./scripts/vendor-leak-guard.sh          # exit 0 if clean, exit 1 with findings
#   ./scripts/vendor-leak-guard.sh --list   # list all files scanned
#
# Wired into: .git/hooks/pre-push
#
# Internal product and vendor strings are blocked from public content.
#
# Exemptions:
#   - .github/workflows/         (CI operational references are allowed)
#   - scripts/vendor-leak-guard.sh itself (contains the pattern list)
#   - CHANGELOG.md               (historical changelog may reference old names)
#   - docs/adr/                  (architecture decision records may reference history)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# --- Scan scope ---
SCAN_DIRS=(
  "$ROOT_DIR/input/fsh"
  "$ROOT_DIR/input/pagecontent"
  "$ROOT_DIR/test/Profile"
  "$ROOT_DIR/sushi-config.yaml"
  "$ROOT_DIR/scripts"
  "$ROOT_DIR/docs"
  "$ROOT_DIR/dist"   # SUSHI/IG Publisher package output (may contain package.json and generated FHIR JSON)
)

# --- Patterns to block (case-insensitive grep) ---
# Each pattern is a separate grep -i match for precision
BLOCKED_PATTERNS=(
  "mi""ra-demo-mvz\.de"
  "\bmi""ra\b"
  "pvs\.cha""rly\.de"
  "pvs-cha""rly"
  "\bcha""rly\b"
  "solu""tio\.de"
  "\bsolu""tio\b"
  "solu""cio"
  "x\.isy""net"
  "xisy""net"
  "\bisy""net\b"
  "\bpola""ris\b"
  "kra""bllink"
  "win""acs"
  "meda""tixx"
  "damp""soft"
  "\bevi""dent\b"
  "tom""edo"
  "epi""kur"
)

# --- Files/paths to exclude from scanning ---
EXCLUDE_PATTERNS=(
  "vendor-leak-guard.sh"
  "CHANGELOG.md"
  "docs/adr/"
  ".github/workflows/"
  ".beads/"        # Internal tooling/bead metadata — not public FHIR content
)

# --- Collect files to scan ---
# For directories: only scan git-tracked files (respects .gitignore).
# For explicit file paths: include as-is (e.g. sushi-config.yaml).
FILES=()
for target in "${SCAN_DIRS[@]}"; do
  if [[ -d "$target" ]]; then
    rel_target="${target#"$ROOT_DIR"/}"
    while IFS= read -r -d '' f; do
      FILES+=("$ROOT_DIR/$f")
    done < <(git -C "$ROOT_DIR" ls-files -z -- "$rel_target" 2>/dev/null \
      | grep -z -E '\.(fsh|md|http|yaml|yml|sh|txt|json)$' || true)
  elif [[ -f "$target" ]]; then
    FILES+=("$target")
  fi
done

# --- Apply exclusions ---
FILTERED_FILES=()
for f in "${FILES[@]}"; do
  skip=false
  for excl in "${EXCLUDE_PATTERNS[@]}"; do
    if [[ "$f" == *"$excl"* ]]; then
      skip=true
      break
    fi
  done
  if [[ "$skip" == "false" ]]; then
    FILTERED_FILES+=("$f")
  fi
done

if [[ "${1:-}" == "--list" ]]; then
  echo "Files scanned (${#FILTERED_FILES[@]}):"
  printf '  %s\n' "${FILTERED_FILES[@]}"
  exit 0
fi

# --- Scan for violations ---
VIOLATIONS=()
for pattern in "${BLOCKED_PATTERNS[@]}"; do
  while IFS= read -r match; do
    VIOLATIONS+=("$match")
  done < <(grep -rn -i -E "$pattern" "${FILTERED_FILES[@]}" 2>/dev/null || true)
done

# --- Report ---
if [[ ${#VIOLATIONS[@]} -eq 0 ]]; then
  echo "vendor-leak-guard: OK — no vendor strings found in public content"
  exit 0
fi

echo "vendor-leak-guard: FAIL — vendor strings detected in public content"
echo ""
echo "Violations (${#VIOLATIONS[@]}):"
printf '  %s\n' "${VIOLATIONS[@]}"
echo ""
echo "Fix: Remove or neutralize vendor-specific strings before pushing."
echo "Exempt files: CHANGELOG.md, docs/adr/, .github/workflows/, scripts/vendor-leak-guard.sh"
exit 1
