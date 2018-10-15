#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null
bin/symbol-new foo > /dev/null

echo 'bad' > foo/src/main.sml

# Should show the error output directly and be in debug.log

echo --- with=smlnj -----------------------------------------------------------
foo/symbol make with=smlnj

echo --- debug.log ------------------------------------------------------------
# We can't print this because ml-makedepend output is not stable across re-runs.
# Each time you run it, it will show different things even for identical inputs.
# cat foo/.symbol-work/debug.log
echo ...omitted...

echo --- with=mlton -----------------------------------------------------------
foo/symbol make with=mlton

echo --- debug.log ------------------------------------------------------------
cat foo/.symbol-work/debug.log
