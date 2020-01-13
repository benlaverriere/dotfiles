#!/bin/bash

# cf. https://github.com/mathiasbynens/dotfiles/blob/master/.bashrc
# shellcheck source=./.bash_profile
[ -n "$PS1" ] && source ~/.bash_profile;

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
