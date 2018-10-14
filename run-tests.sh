#!/usr/bin/env bash

set -euo pipefail

source tests/logging.sh

ARGV=()
UPDATE=
while [[ $# -gt 0 ]]; do
  case $1 in
    --update)
      UPDATE=1
      shift
      ;;
    *)
      ARGV+=("$1")
      shift
      ;;
  esac
done

if [ "${#ARGV[@]}" -eq 0 ]; then
  tests=()
  while IFS=$'\n' read -r line; do
    tests+=("$line");
  done < <(find tests -name '*.sh')
else
  tests=("$@")
fi

failing_tests=()
skipped_tests=()
passing_tests=()
for test in "${tests[@]}"; do
  if ! [ -x "$test" ]; then
    if ! [ "$test" = "tests/logging.sh" ]; then
      skipped_tests+=("$test")
      info "$test"
      warn "└─ test not executable, skipping."
    fi
  else
    info "$test"
    actual="$(mktemp)"
    # shellcheck disable=SC2064
    trap "rm -f '$actual'" EXIT

    if ! "$test" > "$actual"; then
      error "└─ failed. Output:"
      cat "$actual"
      failing_tests+=("$test")
      continue
    fi

    expected="$test.exp"
    if [ -f "$expected" ]; then
      if ! diff -u "$expected" "$actual"; then
        if [ -n "$UPDATE" ]; then
          error "├─ output did not match expected."
          warn  "└─ Updating $expected"
          cat "$actual" > "$expected"
        else
          error "└─ output did not match expected."
        fi
        failing_tests+=("$test")
        continue
      fi
    fi

    success "└─ passed."
    passing_tests+=("$test")

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

if [ "${#skipped_tests[@]}" -ne 0 ]; then
  echo
  echo "───── Skipped tests ────────────────────────────────────────────────────"

  for skipped_test in "${skipped_tests[@]}"; do
    warn "$skipped_test"
  done

  echo
  echo "There were skipped tests. Make sure these files are executable."
  echo

  exit 1
fi

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
