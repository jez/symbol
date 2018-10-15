#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=.
bin/symbol-new foo

pushd foo

./symbol install with=smlnj prefix=..

popd

# With SML/NJ, there will also be a heap image. We want to make sure that the
# program still runs even if we delete the source folder (so it can't reference
# a heap image that's still in there.)
rm -rf foo

bin/foo
