#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold || exit 1

tmp="$(mktemp)"
trap 'rm -f $tmp' EXIT

sml -m TARGET.cm < /dev/null | tee "$tmp"
grep -q 'New bindings added' "$tmp"
