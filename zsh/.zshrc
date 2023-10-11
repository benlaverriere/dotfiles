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

path+=~/bin
# TODO is this still needed? should we use `brew prefix` here?
path+=/usr/local/sbin # for Homebrew formulae
path+="$(python3 -m site --user-base)/bin"
path+="/usr/local/opt/arm-gcc-bin@8/bin" # for QMK
export PATH

### chruby
# if [ $(uname -p) = 'arm' ]; then
#   source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
# else
#   source /usr/local/share/chruby/chruby.sh
# fi
# chruby ruby

### rbenv
export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"

# shellcheck source=../shared_shell/bin/git-prompt.sh
source git-prompt.sh

# set tab title to working dir
precmd() {
  echo -n "\e]1;${PWD##*/}\a"
}

# TODO cache to speed up prompt rendering
__watson_project () {
  watson status -p | sed 's/No project started./∅/'
}

setopt PROMPT_SUBST
PROMPT="%F{cyan}%n%F{10}@%F{green}%m%F{10}:%B%~%F{brgreen}\$(__git_ps1 \"(%s)\")%b
%(!.%F{1}.)➽ %f"
RPROMPT="%F{magenta}〈\$(__watson_project)〉%b"

if [ $(uname -p) = 'arm' ]; then
  export EDITOR=/opt/homebrew/bin/vim
else
  export EDITOR=/usr/local/bin/vim
fi
export PAGER="less -RF -+X"

# use Homebrew's OpenSSL 1.1 rather than the one installed by ruby-build, so that it gets upgraded
# $(brew --prefix openssl@1.1) gives this value, but brew is slow, so we'll hardcode for now
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"

# heroku autocomplete setup, modified to use `~` rather than an explicit username
HEROKU_AC_ZSH_SETUP_PATH=~/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# fastlane tab-completion, if globally installed
[ -f ~/.fastlane ] && . ~/.fastlane/completions/completion.sh

# machine-specific addenda
# shellcheck source=./addenda/sample
for f in ~/zsh_addenda/*; do source "$f"; done

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ben/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ben/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ben/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ben/google-cloud-sdk/completion.zsh.inc'; fi

# Better SSH/Rsync/SCP Autocomplete (https://www.codyhiar.com/blog/zsh-autocomplete-with-ssh-config-file/)
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync|sesh|seshcp):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync|sesh|seshcp):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# see https://carlosbecker.com/posts/speeding-up-zsh
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
compdef sesh=ssh
compdef seshcp=scp
