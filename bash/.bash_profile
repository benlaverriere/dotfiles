#!/bin/bash
export PATH=/usr/local/opt/qt5/bin:/usr/local/bin:~/bin:$PATH

set -o ignoreeof

# cf. https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
# Add tab completion for many Bash commands
if command -v brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  # shellcheck source=/dev/null
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
  # shellcheck source=/dev/null
	source /etc/bash_completion;
fi;

if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
  # shellcheck source=/dev/null
  . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
fi

if [ -f ~/.bash_aliases ]; then
  # shellcheck source=./.bash_aliases
  . ~/.bash_aliases
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# shellcheck source=../shared_shell/bin/colors.sh
source colors.sh
# shellcheck source=../shared_shell/bin/git-prompt.sh
source git-prompt.sh

PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 "(%s)")'
if [ -z ${IN_NIX_SHELL+x} ]; then
  PS1='\[\e[36m\]\u\[\e[0;2m\]@\[\e[0;32m\]\h\[\e[0;2;1m\]:\w\[\e[0;1m\]${PS1_CMD1}\n\[\e[0;96m\]➽\[\e[0m\] '
else
  PS1='\[\e[34m\]\u\[\e[0;2m\]@\[\e[0;34m\]nix\[\e[0;2;1m\]:\w\[\e[0;1m\]${PS1_CMD1}\n\[\e[30;44m\] ⬡ \[\e[0m\] '
fi

export EDITOR=/usr/local/bin/vim
export PAGER="less -RF -+X"
export CPPFLAGS="-I/usr/local/opt/qt5/include"
export LDFLAGS="-L/usr/local/opt/qt5/lib"

# machine-specific addenda
# shellcheck source=./bash_addenda/sample
for f in ~/bash_addenda/*; do source "$f"; done

if [ -e /Users/benlaverriere/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/benlaverriere/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
