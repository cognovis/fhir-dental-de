#!/usr/bin/env bash
set -euo pipefail
root="$(git rev-parse --show-toplevel)"
git -C "$root" config core.hooksPath .githooks
test -x "$(git -C "$root" rev-parse --git-path hooks)/pre-push"
echo "Committed Git hooks installed from .githooks"
