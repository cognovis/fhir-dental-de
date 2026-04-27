#!/usr/bin/env bash
# scripts/check-copyright.sh
#
# Copyright guardrail: check that no copyrighted catalog display texts are present
# in files being committed/pushed.
#
# Usage: ./scripts/check-copyright.sh [--warn-only] [-- <file1> <file2> ...]
#   --warn-only: report findings but exit 0 (transitional mode until fdde-4wi merges)
#   --          : optional file list to scan instead of changed-files detection
#
# When invoked from a pre-push hook, receives commit range via stdin.
# When invoked interactively (no stdin), checks HEAD~1..HEAD.
# When invoked in CI (no stdin, no prior commit), scans the entire repo.
#
# Exit 0: no violations found (or --warn-only). Exit 1: violations found (blocking mode).
#
# Bypass: SKIP_COPYRIGHT_CHECK=1 git push
#         or: git push --no-verify  (also skips sushi check — prefer the env var)

set -euo pipefail

# Bypass: SKIP_COPYRIGHT_CHECK=1 git push (or direct script invocation)
if [ -n "${SKIP_COPYRIGHT_CHECK:-}" ]; then
  exit 0
fi

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

BLOCKLIST="$REPO_ROOT/scripts/copyright-blocklist.txt"

# --- Allowlisted path prefixes (not scanned even when changed) ---
# These directories may legitimately contain catalog text for documentation/ADRs.
ALLOWLIST_PATHS=(
  "docs/"
  "test/"
  ".beads/"
)

# --- Allowlisted specific files (exact match, not prefix) ---
# The blocklist and test script intentionally contain the blocked patterns.
ALLOWLIST_FILES=(
  "scripts/copyright-blocklist.txt"
  "scripts/test-check-copyright.sh"
)

# --- Parse flags and optional file list ---
WARN_ONLY=0
EXPLICIT_FILES=()
PARSE_FILES=0

for arg in "$@"; do
  if [ "$PARSE_FILES" -eq 1 ]; then
    EXPLICIT_FILES+=("$arg")
  elif [ "$arg" = "--warn-only" ]; then
    WARN_ONLY=1
  elif [ "$arg" = "--" ]; then
    PARSE_FILES=1
  else
    echo "Error: unknown argument: $arg" >&2
    exit 2
  fi
done

# --- Resolve scanner (prefer ripgrep for speed) ---
if command -v rg >/dev/null 2>&1; then
  SCANNER="rg"
else
  SCANNER="grep"
fi

# --- Load blocklist patterns ---
if [ ! -f "$BLOCKLIST" ]; then
  echo "⚠️  check-copyright: blocklist not found at $BLOCKLIST — skipping check"
  exit 0
fi

# Extract pattern portion (before the first '|') into a temp patterns file.
# Also build an associative array of pattern -> source-ref for reporting.
PATTERNS_FILE="$(mktemp)"
trap 'rm -f "$PATTERNS_FILE"' EXIT

declare -A PATTERN_SOURCES

while IFS= read -r line; do
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${line// }" ]] && continue
  pattern="${line%%|*}"
  source_ref="${line#*|}"
  if [ -n "$pattern" ]; then
    printf '%s\n' "$pattern" >> "$PATTERNS_FILE"
    PATTERN_SOURCES["$pattern"]="$source_ref"
  fi
done < "$BLOCKLIST"

if [ ! -s "$PATTERNS_FILE" ]; then
  echo "⚠️  check-copyright: blocklist is empty — nothing to check"
  exit 0
fi

# --- Resolve file list ---
FILES_TO_SCAN=()

if [ "${#EXPLICIT_FILES[@]}" -gt 0 ]; then
  # Explicit file list supplied via '--'
  FILES_TO_SCAN=("${EXPLICIT_FILES[@]}")
else
  # Detect range from pre-push stdin (same as check-sushi.sh)
  RANGE=""
  if [ -t 0 ]; then
    # Interactive: check last commit only (if it exists)
    if git rev-parse HEAD~1 >/dev/null 2>&1; then
      RANGE="HEAD~1..HEAD"
    fi
  else
    while read -r local_ref local_sha remote_ref remote_sha; do
      if [ "$local_sha" = "0000000000000000000000000000000000000000" ]; then
        # Branch deletion — nothing to check.
        continue
      fi
      if [ "$remote_sha" = "0000000000000000000000000000000000000000" ]; then
        # New branch — check all commits not yet on remote.
        RANGE="$(git rev-parse origin/main 2>/dev/null || echo HEAD~1)..$local_sha"
      else
        RANGE="$remote_sha..$local_sha"
      fi
      break
    done
  fi

  if [ -n "$RANGE" ]; then
    # Collect changed files from the commit range
    mapfile -t CHANGED_FILES < <(git diff --name-only "$RANGE" 2>/dev/null || true)
    for f in "${CHANGED_FILES[@]}"; do
      [ -f "$REPO_ROOT/$f" ] && FILES_TO_SCAN+=("$f")
    done
  fi

  if [ "${#FILES_TO_SCAN[@]}" -eq 0 ]; then
    # No range or empty range — full-repo scan (CI mode)
    mapfile -t FILES_TO_SCAN < <(
      git ls-files --cached --others --exclude-standard 2>/dev/null \
        | grep -v '\.git/' \
        || true
    )
  fi
fi

if [ "${#FILES_TO_SCAN[@]}" -eq 0 ]; then
  exit 0
fi

# --- Filter out allowlisted paths and files ---
FILTERED_FILES=()
for f in "${FILES_TO_SCAN[@]}"; do
  skip=0
  for prefix in "${ALLOWLIST_PATHS[@]}"; do
    case "$f" in
      "$prefix"*) skip=1; break ;;
    esac
  done
  if [ "$skip" -eq 0 ]; then
    for exact in "${ALLOWLIST_FILES[@]}"; do
      if [ "$f" = "$exact" ]; then
        skip=1; break
      fi
    done
  fi
  [ "$skip" -eq 0 ] && FILTERED_FILES+=("$f")
done

if [ "${#FILTERED_FILES[@]}" -eq 0 ]; then
  exit 0
fi

echo ""
echo "🔍 check-copyright: scanning ${#FILTERED_FILES[@]} file(s) for copyrighted catalog texts..."
echo ""

# --- Single-pass scan using all patterns at once ---
# rg --fixed-strings --file reads one pattern per line; much faster than per-pattern loops.
# For grep fallback, we build an alternation regex (slower but correct).

RAW_MATCHES=()

if [ "$SCANNER" = "rg" ]; then
  mapfile -t RAW_MATCHES < <(
    rg --fixed-strings --file "$PATTERNS_FILE" \
       --with-filename --line-number \
       "${FILTERED_FILES[@]}" 2>/dev/null \
    | grep -v 'copyright-allowlist:' \
    || true
  )
else
  mapfile -t RAW_MATCHES < <(
    grep --fixed-strings --file "$PATTERNS_FILE" \
         --with-filename --line-number \
         "${FILTERED_FILES[@]}" 2>/dev/null \
    | grep -v 'copyright-allowlist:' \
    || true
  )
fi

# --- Annotate matches with source references ---
VIOLATIONS=()
for match in "${RAW_MATCHES[@]}"; do
  # match format: "filepath:lineno:content"
  match_content="${match#*:}"  # strip "filepath:"
  match_content="${match_content#*:}"  # strip "lineno:"
  match_content="${match_content#"${match_content%%[![:space:]]*}"}"  # ltrim

  # Find which pattern(s) matched this line
  source_annotation=""
  for pattern in "${!PATTERN_SOURCES[@]}"; do
    if [[ "$match_content" == *"$pattern"* ]]; then
      ref="${PATTERN_SOURCES[$pattern]}"
      source_annotation="${source_annotation:+$source_annotation, }$ref"
    fi
  done

  VIOLATIONS+=("$match [${source_annotation:-unknown}]")
done

# --- Report ---
if [ "${#VIOLATIONS[@]}" -eq 0 ]; then
  echo "✅ check-copyright: no copyrighted catalog texts found"
  exit 0
fi

echo "❌ check-copyright: found ${#VIOLATIONS[@]} copyrighted catalog text(s):"
echo ""
for v in "${VIOLATIONS[@]}"; do
  echo "   $v"
done
echo ""

if [ "$WARN_ONLY" -eq 1 ]; then
  echo "⚠️  check-copyright: running in warn-only mode (--warn-only) — push allowed."
  echo "   Warn-only mode is active until fdde-4wi merges and removes existing violations."
  echo "   After that, this check becomes blocking. To suppress a finding, use:"
  echo "     - inline marker: # copyright-allowlist: <reason>"
  echo "     - or remove the flagged string"
  echo ""
  exit 0
fi

echo "   Push blocked. To fix:"
echo "   1. Remove or replace the copyrighted display texts listed above."
echo "   2. Or add '# copyright-allowlist: <reason>' at the end of the line."
echo "   3. Emergency bypass: SKIP_COPYRIGHT_CHECK=1 git push"
echo "   4. Or: git push --no-verify  (also skips sushi check)"
echo ""
exit 1
