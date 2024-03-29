#!/usr/bin/env bash

# See README for this script's prerequisites

# Set up a Ruby installation that's entirely within our control:
script/ruby.sh

# Then install everything else:
bundle exec rake fix

# Specify Homebrew's zsh (installed already from `Brewfile`) per
# [these instructions](https://stackoverflow.com/a/17649823), with credit to
# [this answer](https://stackoverflow.com/a/3557165):
script/switch_zsh.sh

# Finally, use `stow` to symlink the config directories in this repository to your home directory:
script/stow_it_all.sh

## Application/tool-specific followup actions

"$(brew --prefix)/opt/fzf/install"
script/iterm.sh
#script/qmk.sh
script/kokoi.sh
script/terminfo.sh
