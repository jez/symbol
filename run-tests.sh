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
passing_tests=()
for test in "${tests[@]}"; do
  if ! [ -x "$test" ]; then
    warn "$test is not executable, skipping..."
  else
    echo
    info "Running test: $test ..."
    if "$test"; then
      success "└─ $test passed."
      passing_tests+=("$test")
    else
      error "└─ $test failed."
      failing_tests+=("$test")
    fi

    info "Cleaning ignored files..."
    # Removes files ignored by Git.
    # Changes to tracked / unignored files will carry over from test to test!
    git clean -dfX &> /dev/null
  fi
done

echo
echo

echo "───── Passing tests ────────────────────────────────────────────────────"
for passing_test in "${passing_tests[@]}"; do
  success "$passing_test"
done

if [ "${#failing_tests[@]}" -ne 0 ]; then
  echo
  echo "───── Failing tests ────────────────────────────────────────────────────"

  for failing_test in "${failing_tests[@]}"; do
    error "$failing_test"
  done

  echo
  echo "There were failing tests. To re-run all failing tests:"
  echo
  echo "    ./run-tests.sh ${failing_tests[*]}"
  echo

  exit 1
fi
