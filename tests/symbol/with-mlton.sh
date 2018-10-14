#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold

./symbol make with=mlton

target=.symbol-work/bin/TARGET

if ! [ -f "$target" ]; then
  fatal "Didn't build successfully."
fi

if ! [ -x "$target" ]; then
  fatal "TARGET is not executable."
fi

is_binary() {
  ! grep -qI '.' "$1"
}

if ! is_binary "$target"; then
  fatal "TARGET is not a binary; are we sure it was built with MLton?"
fi

if ! "$target"; then
  fatal "Running TARGET returned non-zero status"
fi
