set shell := ["zsh", "-cu"]

default:
  just --list

[group('setup')]
[confirm]
bootstrap email: (configure-git email) install-ruby fix configure-zsh stow install-fzf configure-iterm install-kokoi configure-terminfo

[group('setup')]
configure-git email:
  #!/usr/bin/env zsh
  set -euxo pipefail
  if [ ! -f ~/.gitconfig_local ]; then
    echo '[user]\n  name = "Ben LaVerriere"\n  email = {{email}}' > ~/.gitconfig_local 
  fi

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

# apply updates to all modules
[group('frequent')]
[group('fix')]
fix: bundle fix-most

# check all modules for updates, but do not apply any changes
[group('frequent')]
[group('check')]
check: bundle check-most

[group('frequent')]
bundle:
  bundle check || bundle install

[group('frequent')]
add-vim-plugin url alias='':
  script/add_vim_plugin.rb {{url}} {{alias}}

[group('fix')]
fix-most: fix-brewfile fix-cask fix-formulae fix-git fix-vim

[group('fix')]
fix-all: fix-most fix-qmk

[group('check')]
check-most: check-brewfile check-cask check-formulae check-git check-vim

[group('check')]
check-all: check-most check-qmk

[group('check')]
check-brewfile: bundle
  bundle exec rake check:brewfile

[group('check')]
check-cask: bundle
  bundle exec rake check:cask

[group('check')]
check-formulae: bundle
  bundle exec rake check:formulae

[group('check')]
check-git: bundle
  bundle exec rake check:git

[group('check')]
check-vim: bundle
  bundle exec rake check:vim

[group('check')]
check-qmk: bundle
  bundle exec rake check:qmk

[group('fix')]
fix-brewfile: bundle
  bundle exec rake fix:brewfile

[group('fix')]
fix-cask: bundle
  bundle exec rake fix:cask

[group('fix')]
fix-formulae: bundle
  bundle exec rake fix:formulae

[group('fix')]
fix-git: bundle
  bundle exec rake fix:git

[group('fix')]
fix-vim: bundle
  bundle exec rake fix:vim

[group('fix')]
fix-qmk: bundle
  bundle exec rake fix:qmk
