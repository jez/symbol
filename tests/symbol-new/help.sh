#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

bin/symbol-new -h

echo
echo --------------------------------------------------------------------------
echo

bin/symbol-new --help
