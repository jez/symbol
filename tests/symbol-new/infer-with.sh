#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

is_binary() {
  ! grep -qI '.' "$1"
}

make install prefix=. &> /dev/null
bin/symbol-new foo > /dev/null

cd foo

./symbol make

if ! grep -q '^exec sml ' ".symbol-work/bin/foo"; then
  fatal "Did not infer with=smlnj for no arguments"
fi

rm foo.cm
./symbol make

if ! is_binary ".symbol-work/bin/foo"; then
  fatal "Did not infer with=mlton when no *.cm file"
fi

rm foo.mlb

if ./symbol make; then
  fatal "Expected error when can't infer with= from filesystem."
fi
