#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

is_binary() {
  ! grep -qI '.' "$1"
}

cd scaffold

./symbol make

if ! grep -q '^exec sml ' ".symbol-work/bin/TARGET"; then
  fatal "Didn't infer 'with=smlnj' for make subcommand"
fi

./symbol install prefix=.

if ! is_binary "bin/TARGET"; then
  fatal "Didn't infer 'with=mlton' for install subcommand"
fi
