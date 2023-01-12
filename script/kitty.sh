#!/usr/bin/env bash

set -eu

# there should already be a submodule in this dir:
icon_source="src_not_stowed/kitty_icon_whiskers/whiskers-tokyo.png"
kitty_config_dir="$HOME/.config/kitty/"

cp "$icon_source" "$kitty_config_dir/kitty.app.png"

# clear cached old icon
rm /var/folders/*/*/*/com.apple.dock.iconcache; killall Dock
