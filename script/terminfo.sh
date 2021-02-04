#!/usr/bin/env bash

# adapted from https://sookocheff.com/post/vim/italics/

pushd "src_not_stowed" || exit 1

whoami
tic -o "$HOME/.terminfo" tmux.terminfo
tic -o "$HOME/.terminfo" tmux-256color.terminfo
tic -o "$HOME/.terminfo" xterm-256color.terminfo

popd > /dev/null || return
