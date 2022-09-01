#!/usr/bin/env bash

# Add Homebrew's zsh to the list of allowed shells and switch to it.

ZSH_LINE="$(brew --prefix)/bin/zsh"
TARGET_FILE='/etc/shells'

  sudo grep -qxF "$ZSH_LINE" "$TARGET_FILE" || echo "$ZSH_LINE" | sudo tee -a "$TARGET_FILE" > /dev/null
# ^ check if we already have this shell specified.
#                                           ^ if that fails,
#                                              ^ add it
#                                                               ^ via a privileged `tee` with the -a[ppend] flag
#                                                                                            ^ and discard tee's output

  chsh -s "$ZSH_LINE"
# ^ change our login shell to the newly-installed and -allowed zsh
