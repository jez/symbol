#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

target=.symbol-work/bin/TARGET

cd scaffold

echo --- first build ----------------------------------------------------------

./symbol make with=smlnj

if ! [ -f "$target" ]; then
  fatal "Didn't build successfully."
fi

if ! [ -x "$target" ]; then
  fatal "TARGET is not executable."
fi

if ! grep -q '^exec sml ' "$target"; then
  fatal "TARGET does not exec SML/NJ"
fi

if ! [ -f .symbol-work/debug.log ]; then
  fatal "debug.log is missing"
fi

echo --- scaffold output ------------------------------------------------------

if ! "$target"; then
  fatal "Running TARGET returned non-zero status"
fi

echo --- second build ---------------------------------------------------------

./symbol make with=smlnj

echo --- install --------------------------------------------------------------

./symbol install with=smlnj prefix=.

echo --- install output -------------------------------------------------------

bin/TARGET
