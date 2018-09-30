#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold || exit 1

tmp="$(mktemp)"
trap 'rm -f $tmp' EXIT

sml -m TARGET.cm < /dev/null | tee "$tmp"

if grep -q 'New bindings added' "$tmp"; then
  success "scaffold typechecks under SML/NJ"
else
  error "scaffold does not typecheck under SML/NJ"
  exit 1
fi

