#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

make install prefix=. &> /dev/null

# TODO(jez) This would probably be better suited as a snapshot test.
# If you add snapshot tests, also add a way to automatically update them.

check_help() {
  grep -q 'symbol-new: '
}

if ! { bin/symbol-new -h | check_help ; }; then
  error "Did not see symbol-new help output with -h"
  exit 1
fi

if ! { bin/symbol-new --help | check_help ; }; then
  error "Did not see symbol-new help output with --help"
  exit 1
fi
