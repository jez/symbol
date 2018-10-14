#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

bin/symbol-new --version

echo -----

bin/symbol-new foo &> /dev/null
foo/symbol --version
