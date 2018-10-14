#!/usr/bin/env bash

set -euo pipefail
set -x

source tests/logging.sh

make install prefix=. &> /dev/null

bin/symbol-new --version

echo -----

bin/symbol-new foo
foo/symbol --version

if [ -d foo/.symbol-work ]; then
  fatal "Asking for --version created .symbol-work folder"
fi
