#!/usr/bin/env zsh

# doesn't include bash, for the moment

# make this a fix/check script, using chkstow to check and maybe -R to re-stow?
# would be nice to have one mechanism (Rake) for cleaning everything up
stow zsh
stow shared_shell
stow git
stow tmux
stow vim
stow iterm
stow misc

ln -f -s "$(pwd)/src_not_stowed/git-format-staged/git-format-staged" "$HOME/bin"

stow --dir ./qmk --target ./qmk/zsa_qmk_firmware/keyboards keyboards
ln -f -s "$(pwd)/qmk/qmk.ini" "$HOME/Library/Application Support/qmk"
