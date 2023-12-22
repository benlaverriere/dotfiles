#!/usr/bin/env bash

# adapted from https://sookocheff.com/post/vim/italics/

set -ue
pushd "src_not_stowed" > /dev/null || exit 1

set -x

tic -o "$HOME/.terminfo" tmux.terminfo
tic -o "$HOME/.terminfo" tmux-256color.terminfo

# -x: treat unknown capabilities as user-defined
# (allows Smulx to compile, enabling undercurl)
tic -x -o "$HOME/.terminfo" xterm-256color.terminfo

{ set +x; } 2>/dev/null

popd > /dev/null || return
