#!/bin/sh

# Courtesy @hughescr — https://github.com/bloomberg/xcdiff/issues/25#issuecomment-1419615657
#
# Called by git as
# cmd path old-file old-hex old-mode new-file new-hex new-mode

#THE_PATH=$1

OLD_FILE=$2
#OLD_HEX=$3
#OLD_MODE=$4

NEW_FILE=$5
#NEW_HEX=$6
#NEW_MODE=$7

xcdiff -d -p1 "$(dirname "$OLD_FILE")" -p2 "$(dirname "$NEW_FILE")" -v || true
