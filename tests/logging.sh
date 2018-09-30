#!/usr/bin/env bash

red=$'\x1b[0;31m'
green=$'\x1b[0;32m'
yellow=$'\x1b[0;33m'
cyan=$'\x1b[0;36m'
cnone=$'\x1b[0m'

if [ -t 1 ]; then
  USE_COLOR=1
else
  USE_COLOR=0
fi

# Detects whether we can add colors or not
in_color() {
  local color="$1"
  shift

  if [ "$USE_COLOR" = "1" ]; then
    echo "$color$*$cnone"
  else
    echo "$*"
  fi
}

success() { echo "$(in_color "$green" "[ OK ]") $*"; }
error() {   echo "$(in_color "$red"   "[ERR!]") $*"; }
info() {    echo "$(in_color "$cyan"  "[INFO]") $*"; }
# Color entire warning to get users' attention (because we won't stop).
warn() { in_color "$yellow" "[WARN] $*"; }
