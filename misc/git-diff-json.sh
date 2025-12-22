#!/usr/bin/env bash

# Called by git as
# cmd path old-file old-hex old-mode new-file new-hex new-mode

set -euo pipefail

THE_PATH=$1

OLD_FILE=$2
OLD_HEX=$3
OLD_MODE=$4

NEW_FILE=$5
NEW_HEX=$6
NEW_MODE=$7

jd -git-diff-driver -color \
  "$THE_PATH" \
  <(jq '.' "$OLD_FILE") \
  "$OLD_HEX" \
  "$OLD_MODE" \
  <(jq '.' "$NEW_FILE") \
  "$NEW_HEX" \
  "$NEW_MODE"
