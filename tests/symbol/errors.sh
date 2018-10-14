#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold

if ! symbol --foo; then
  error "Expected non-zero return"
fi

echo --------------------------------------------------------------------------

if symbol make --foo; then
  error "Expected non-zero return"
fi

echo --------------------------------------------------------------------------

if symbol make foo; then
  error "Expected non-zero return"
fi

echo --------------------------------------------------------------------------

if symbol make with=foo; then
  error "Expected non-zero return"
fi
