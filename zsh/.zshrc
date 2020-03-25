setopt AUTO_CD
cdpath+=$HOME

setopt CORRECT
setopt CORRECT_ALL
setopt NO_CASE_GLOB
setopt GLOBDOTS

# forward-delete
bindkey "^[[3~"  delete-char
bindkey "^[3;5~" delete-char

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
# End of lines added by compinstall

# see https://carlosbecker.com/posts/speeding-up-zsh
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

path+=~/bin
path+=/usr/local/sbin # for Homebrew formulae
path+=~/.rbenv/bin
export PATH

# shellcheck source=../bash/bin/git-prompt.sh
source git-prompt.sh

setopt PROMPT_SUBST
PROMPT="%F{cyan}%n%F{10}@%F{green}%m%F{10}:%B%~%F{brgreen}\$(__git_ps1 \"(%s)\")%b
%(!.%F{1}.)➽ %f"

export EDITOR=/usr/local/bin/vim
export PAGER="less -RF -+X"

# use Homebrew's OpenSSL 1.1 rather than the one installed by ruby-build, so that it gets upgraded
# $(brew --prefix openssl@1.1) gives this value, but brew is slow, so we'll hardcode for now
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"

eval "$(rbenv init -)"

# heroku autocomplete setup, modified to use `~` rather than an explicit username
HEROKU_AC_ZSH_SETUP_PATH=~/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# machine-specific addenda
# shellcheck source=./addenda/sample
for f in ~/zsh_addenda/*; do source "$f"; done