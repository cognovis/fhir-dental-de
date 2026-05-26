#!/usr/bin/env bash
# scripts/prefetch-praxis.sh
#
# Prefetch the latest fhir-praxis-de release into the local FHIR package cache.
#
# Why: sushi resolves dependencies from `~/.fhir/packages/` only — it does NOT
# know about npm.cognovis.de (Verdaccio). When sushi-config.yaml is bumped to a
# praxis version that is not in the local cache, sushi attempts to download from
# packages2.fhir.org and fails with "Failed to download from registry".
#
# CI (.github/workflows/ig-ci.yml) auto-fetches from GitHub releases on every
# run. This script mirrors that logic for local development.
#
# Usage:
#   ./scripts/prefetch-praxis.sh                # fetch pinned version (v0.69.1)
#   ./scripts/prefetch-praxis.sh v0.69.1        # fetch pinned version explicitly
#   ./scripts/prefetch-praxis.sh latest         # fetch latest release
#
# Exit 0: cache populated. Exit 1: download failed.

set -euo pipefail

REPO="cognovis/fhir-praxis-de"
TAG="${1:-v0.69.1}"
CACHE_DIR="$HOME/.fhir/packages"

if [ "$TAG" = "latest" ]; then
  RELEASE_URL="https://api.github.com/repos/$REPO/releases/latest"
else
  RELEASE_URL="https://api.github.com/repos/$REPO/releases/tags/$TAG"
fi

echo "Resolving praxis release ($TAG) ..."
RELEASE_JSON=$(curl -s "$RELEASE_URL")
ASSET_URL=$(echo "$RELEASE_JSON" | jq -r '[.assets[]? | select(.name | startswith("de.cognovis.fhir.praxis"))] | last | .browser_download_url // empty')

TMP_TGZ=$(mktemp -t praxis-XXXXXX.tgz)
trap 'rm -f "$TMP_TGZ"' EXIT

if [ -n "$ASSET_URL" ]; then
  echo "Downloading from GitHub release: $ASSET_URL"
  curl -L -s -o "$TMP_TGZ" "$ASSET_URL"
else
  PRAXIS_VER="${TAG#v}"
  NPM_URL="https://npm.cognovis.de/de.cognovis.fhir.praxis/-/de.cognovis.fhir.praxis-${PRAXIS_VER}.tgz"
  echo "GitHub release $TAG not found; falling back to npm.cognovis.de: $NPM_URL"
  curl -L -s -o "$TMP_TGZ" "$NPM_URL"
fi

# Extract version from package.json inside the tarball
VERSION=$(tar xzf "$TMP_TGZ" -O package/package.json | jq -r '.version')
echo "Praxis version: $VERSION"

PKG_DIR="$CACHE_DIR/de.cognovis.fhir.praxis#$VERSION"
if [ -d "$PKG_DIR" ] && [ -f "$PKG_DIR/package/package.json" ]; then
  echo "Already cached at $PKG_DIR — nothing to do."
  exit 0
fi

mkdir -p "$PKG_DIR"
tar xzf "$TMP_TGZ" -C "$PKG_DIR/"
echo "Cached to $PKG_DIR"

# Verify
if [ -f "$PKG_DIR/package/package.json" ]; then
  echo "OK — sushi will now resolve de.cognovis.fhir.praxis#$VERSION locally."
else
  echo "::error::Extraction failed — package/package.json not found at $PKG_DIR" >&2
  exit 1
fi
