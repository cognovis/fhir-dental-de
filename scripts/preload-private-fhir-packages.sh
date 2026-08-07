#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "Usage: $0 [--list-private-dependencies <sushi-config>] [--verify-cache <sushi-config> <cache-dir>] [<sushi-config>]" >&2
}

private_dependencies() {
  local config_path="$1"

  awk '
    /^dependencies:[[:space:]]*$/ { in_dependencies = 1; next }
    in_dependencies && /^[^[:space:]#]/ { exit }
    in_dependencies && /^[[:space:]]+de\.cognovis\.[^:]+:[[:space:]]*[^[:space:]#]+/ {
      line = $0
      sub(/^[[:space:]]+/, "", line)
      split(line, fields, ":")
      package_name = fields[1]
      version = fields[2]
      sub(/^[[:space:]]+/, "", version)
      sub(/[[:space:]]+#.*$/, "", version)
      sub(/[[:space:]]+$/, "", version)
      print package_name "\t" version
    }
  ' "$config_path"
}

verify_cache() {
  local config_path="$1"
  local cache_dir="$2"
  local missing=0
  local package_name version package_cache

  while IFS=$'\t' read -r package_name version; do
    test -n "$package_name" || continue
    package_cache="$cache_dir/${package_name}#${version}/package/package.json"
    if ! test -f "$package_cache"; then
      echo "Missing declared private package from FHIR cache: ${package_name}#${version}" >&2
      missing=1
    fi
  done < <(private_dependencies "$config_path")

  test "$missing" -eq 0
}

configure_registry_auth() {
  if test -z "${VERDACCIO_TOKEN:-}"; then
    echo "VERDACCIO_TOKEN is required to fetch private FHIR packages" >&2
    exit 1
  fi

  {
    echo "//npm.cognovis.de/:_password=${VERDACCIO_TOKEN}"
    echo "//npm.cognovis.de/:username=cognovis"
    echo "//npm.cognovis.de/:email=info@cognovis.de"
    echo "//npm.cognovis.de/:always-auth=true"
  } >> "$HOME/.npmrc"
}

fetch_to_fhir_cache() {
  local package_name="$1"
  local version="$2"
  local cache_key="${package_name}#${version}"
  local cache_dir="${FHIR_PACKAGES_DIR}/${cache_key}"
  local package_directory

  test -z "${PROCESSED[$cache_key]:-}" || return 0
  PROCESSED[$cache_key]=1

  if test -f "$cache_dir/package/package.json"; then
    echo "$cache_key already cached — skipping fetch"
  else
    local pack_dir tgz
    echo "Fetching ${package_name}@${version} from npm.cognovis.de..."
    pack_dir="$(mktemp -d)"
    (
      cd "$pack_dir"
      npm pack "${package_name}@${version}" --registry https://npm.cognovis.de >/dev/null
    )
    tgz="$(find "$pack_dir" -maxdepth 1 -name '*.tgz' -print -quit)"
    test -n "$tgz"
    mkdir -p "$cache_dir"
    tar xzf "$tgz" -C "$cache_dir"
    rm -rf "$pack_dir"
  fi

  package_directory="$cache_dir/package/package.json"
  while IFS=$'\t' read -r dependency_name dependency_version; do
    test -n "$dependency_name" || continue
    fetch_to_fhir_cache "$dependency_name" "$dependency_version"
  done < <(
    node - "$package_directory" <<'NODE'
const fs = require("node:fs");
const packageJson = JSON.parse(fs.readFileSync(process.argv[2], "utf8"));
for (const [name, version] of Object.entries(packageJson.dependencies ?? {})) {
  if (name.startsWith("de.cognovis.")) {
    process.stdout.write(`${name}\t${version}\n`);
  }
}
NODE
  )
}

case "${1:-}" in
  --list-private-dependencies)
    test "$#" -eq 2 || { usage; exit 2; }
    private_dependencies "$2"
    ;;
  --verify-cache)
    test "$#" -eq 3 || { usage; exit 2; }
    verify_cache "$2" "$3"
    ;;
  *)
    test "$#" -le 1 || { usage; exit 2; }
    SUSHI_CONFIG_PATH="${1:-sushi-config.yaml}"
    FHIR_PACKAGES_DIR="${FHIR_PACKAGES_DIR:-$HOME/.fhir/packages}"
    test -f "$SUSHI_CONFIG_PATH" || { echo "SUSHI config does not exist: $SUSHI_CONFIG_PATH" >&2; exit 1; }
    configure_registry_auth
    mkdir -p "$FHIR_PACKAGES_DIR"
    declare -A PROCESSED
    while IFS=$'\t' read -r package_name version; do
      test -n "$package_name" || continue
      fetch_to_fhir_cache "$package_name" "$version"
    done < <(private_dependencies "$SUSHI_CONFIG_PATH")
    verify_cache "$SUSHI_CONFIG_PATH" "$FHIR_PACKAGES_DIR"
    ;;
esac
