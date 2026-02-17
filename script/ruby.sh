#!/usr/bin/env zsh

# Set up a Ruby installation that's entirely within our control, inspired by
# https://github.com/monfresh/install-ruby-on-macos

# Replicating the Brewfile a bit, but this allows us to run ruby.sh before installing the whole Brewfile
brew install ruby-build
brew install rbenv
# TODO: do whatever setup rbenv wants

# Install the version in .ruby-version
rbenv install

# Bundler
gem update --system
gem install bundler && gem update bundler
bundle install
