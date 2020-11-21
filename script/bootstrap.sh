#!/usr/bin/env bash

# Initialize submodules in this repository (used for Vim plugin management).
# After first install, `beer_run` will update these.
git submodule update --init --remote --merge

# Then install everything else:
script/beer_run.rb fix

# Specify Homebrew's zsh (installed already from `Brewfile`) per
# [these instructions](https://stackoverflow.com/a/17649823), with credit to
# [this answer](https://stackoverflow.com/a/3557165):
script/switch_zsh.sh

# Finally, use `stow` to symlink the config directories in this repository to your home directory:
script/stow_it_all.sh

# Set up a Ruby installation that's entirely within our control, inspired by https://github.com/monfresh/install-ruby-on-macos
ruby-install ruby
chruby ruby
gem update --system
gem install bundler && gem update bundler
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))
bundle install

## Application/tool-specific followup actions

"$(brew --prefix)/opt/fzf/install"
script/iterm.sh
script/qmk.sh
script/kokoi.sh
