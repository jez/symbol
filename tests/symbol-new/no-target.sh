#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

if bin/symbol-new; then
  fatal "symbol-new did not exit with non-zero status"
fi
