#!/usr/bin/env zsh

# doesn't include bash, for the moment

stow zsh
stow shared_shell
stow git
stow tmux
stow vim
stow iterm

stow --dir ./qmk --target ./qmk/zsa_qmk_firmware/keyboards keyboards
