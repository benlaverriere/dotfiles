#!/usr/bin/env bash

pushd iterm/iterm_profile > /dev/null || exit 1

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/iterm_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

popd > /dev/null || return
