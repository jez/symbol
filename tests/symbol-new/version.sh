#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

bin/symbol-new --version

echo -----

bin/symbol-new foo &> /dev/null
foo/symbol --version

if [ -d foo/.symbol-work ]; then
  error "Asking for --version created .symbol-work folder"
  exit 1
fi
