#!/usr/bin/env bash

set -euo pipefail
source tests/logging.sh

cd scaffold

symbol
echo --------------------------------------------------------------------------
symbol -h
echo --------------------------------------------------------------------------
symbol --help
echo --------------------------------------------------------------------------
symbol help
