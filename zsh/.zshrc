setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL
setopt NO_CASE_GLOB

if [ -f ~/.zsh_aliases ]; then
  # shellcheck source=./.zsh_aliases
  . ~/.zsh_aliases
fi

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

path+=~/bin
export PATH

# shellcheck source=../bash/bin/git-prompt.sh
source git-prompt.sh

setopt PROMPT_SUBST
PROMPT="%F{cyan}%n%F{10}@%F{green}%m%F{10}:%B%~%F{brgreen}\$(__git_ps1 \"(%s)\")%b
%(!.%F{1}.)➽ %f"

export EDITOR=/usr/local/bin/vim
export PAGER="less -RF -+X"
