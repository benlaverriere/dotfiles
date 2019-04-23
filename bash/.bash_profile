export PATH=/usr/local/bin:~/bin:$PATH

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

source ./bin/colors.sh
source ./bin/git-prompt.sh

export PS1="$Cyan\u$BGreen@$Green\h$BGreen:\w$BCyan\$(__git_ps1 \"(%s)\")$Color_Off\n➽  "
export EDITOR=/usr/local/bin/vim
export PAGER="less -RF -+X"

# machine-specific addenda
# arguably this shouldn't be a fixed path but...
# shellcheck source=/dev/null
for f in ~/dotfiles/bash/addenda/*; do source "$f"; done
