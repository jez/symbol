#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold

symbol make with=smlnj

target=.symbol-work/bin/TARGET

if ! [ -f "$target" ]; then
  fatal "Didn't build successfully."
fi

if ! [ -x "$target" ]; then
  fatal "TARGET is not executable."
fi

if ! grep -q '^exec sml ' "$target"; then
  fatal "TARGET does not exec SML/NJ"
fi

if ! "$target"; then
  fatal "Running TARGET returned non-zero status"
fi
