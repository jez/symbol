#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold || exit 1

tmp="$(mktemp)"
trap 'rm -f $tmp' EXIT

mlton -stop tc TARGET.mlb
