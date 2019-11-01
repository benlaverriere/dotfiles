#!/bin/bash

# cf. https://github.com/mathiasbynens/dotfiles/blob/master/.bashrc
# shellcheck source=./.bash_profile
[ -n "$PS1" ] && source ~/.bash_profile;


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
