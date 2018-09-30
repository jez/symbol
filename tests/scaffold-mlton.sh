#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold || exit 1

tmp="$(mktemp)"
trap 'rm -f $tmp' EXIT

if mlton -stop tc TARGET.mlb; then
  success "scaffold typechecks under MLton"
else
  error "scaffold does not typecheck under MLton"
  exit 1
fi

