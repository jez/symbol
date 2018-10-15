#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

bin/symbol-new foo --empty

num_files="$(find foo -type f | wc -l)"

if [ "$num_files" -ne 2 ]; then
  fatal "Expected total 2 files, found $num_files files."
fi
