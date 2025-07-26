set shell := ["zsh", "-cu"]

default:
  just --list

# before this:
# - install Git
# - create .gitconfig_local
# - install Homebrew
# - install Just
# - clone the repo

[group('setup')]
[confirm]
bootstrap: install-ruby fix configure-zsh stow install-fzf configure-iterm install-kokoi configure-terminfo

[group('setup')]
configure-zsh:
  script/switch_zsh.sh

[group('setup')]
stow:
  script/stow_it_all.sh

[group('setup')]
install-fzf:
  $(brew --prefix)/opt/fzf/install

[group('setup')]
configure-iterm:
  script/iterm.sh

# actually just needs to depend on a `brew install`

[group('setup')]
install-kokoi: fix
  npm install kokoi -g

[group('setup')]
configure-terminfo:
  script/terminfo.sh

[group('setup')]
install-ruby:
  script/ruby.sh

[group('frequent')]
fix: bundle
  bundle exec rake fix

[group('frequent')]
check: bundle
  bundle exec rake check

[group('frequent')]
bundle:
  bundle check || bundle install

[group('frequent')]
add-vim-plugin url alias='':
  script/add_vim_plugin.rb {{url}} {{alias}}
