#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

is_binary() {
  ! grep -qI '.' "$1"
}
target=.symbol-work/bin/TARGET

cd scaffold

echo --- first build ----------------------------------------------------------

./symbol make with=mlton

if ! [ -f "$target" ]; then
  fatal "Didn't build successfully."
fi

if ! [ -x "$target" ]; then
  fatal "TARGET is not executable."
fi

if ! is_binary "$target"; then
  fatal "TARGET is not a binary; are we sure it was built with MLton?"
fi

if ! [ -f .symbol-work/debug.log ]; then
  fatal "debug.log is missing"
fi

echo --- scaffold output ------------------------------------------------------

if ! "$target"; then
  fatal "Running TARGET returned non-zero status"
fi

echo --- second build ---------------------------------------------------------

./symbol make with=mlton

echo --- install --------------------------------------------------------------

./symbol install with=mlton prefix=.

echo --- install output -------------------------------------------------------

bin/TARGET
