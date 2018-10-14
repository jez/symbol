#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

is_binary() {
  ! grep -qI '.' "$1"
}
target=.symbol-work/bin/TARGET

cd scaffold
./symbol make with=smlnj

if ! grep -q '^exec sml ' "$target"; then
  fatal "Didn't build with=smlnj first"
fi

./symbol make with=mlton

if ! is_binary "$target"; then
  fatal "Didn't overwrite SML/NJ executable with MLton"
fi

./symbol make with=smlnj

if ! grep -q '^exec sml ' "$target"; then
  fatal "Didn't overwrite MLton executable with SML/NJ"
fi

