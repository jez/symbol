#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

mkdir foo
cd foo

if ../bin/symbol-new . --empty; then
  fatal "Expected '.' target name to be rejected with info message."
fi
