#!/usr/bin/env bash

set -euo pipefail

source tests/logging.sh

if [ "$#" -eq 0 ]; then
  tests=()
  while IFS=$'\n' read -r line; do
    tests+=("$line");
  done < <(find tests -name '*.sh')
else
  tests=("$@")
fi

failing_tests=()
for test in "${tests[@]}"; do
  if ! [ -x "$test" ]; then
    warn "$test is not executable, skipping..."
  else
    echo
    info "Running test: $test ..."
    if "$test"; then
      success "└─ $test passed."
    else
      error "└─ $test failed."
      failing_tests+=("$test")
    fi
  fi
done

if [ "${#failing_tests[@]}" -ne 0 ]; then
  info "Summary of failing tests:"
  for failing_test in "${failing_tests[@]}"; do
    echo "$failing_test"
  done
  error "There were failing tests. To re-run all failing tests:"
  echo "./run-tests.sh ${failing_tests[*]}"
  exit 1
fi
