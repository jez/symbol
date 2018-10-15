#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

mkdir foo
touch foo/README.md
bin/symbol-new foo --empty

num_files="$(find foo -type f | wc -l)"

if [ "$num_files" -ne 3 ]; then
  fatal "Expected total 3 files, found $num_files files."
fi
