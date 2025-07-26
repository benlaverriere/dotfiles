# dotfiles

[Install Homebrew](https://brew.sh/) so that we can install other software.

Run the following script:

```sh
!/usr/bin/env zsh

brew install git
brew install just

```

Clone this repo.

Run `just bootstrap` to set everything up for the first time.
Thereafter, run `just fix` to update things.

## resources

- [Vim 8 native package management](https://shapeshed.com/vim-packages/)
  - You probably want `just add-vim-plugin <url> [submodule_alias]`


## TODO

- figure out distinction between Rake and `stow_it_all` tasks, or combine
- replace TeXShop with standalone TeXLive
- split Brewfile into "critical" and "everything else"
- store kitty config in repo
- purge old installed formulae/casks (like old Pythons)
- Just dependencies somewhat overlap with Rake dependencies. Not sure if the "accumulate advice" model translates well to Just, though.

## QMK

- `script/qmk.sh` and maybe other setup via Homebrew
- `qmk configure` and `qmk flash`
- Using a weekly build of Plover until 4.0 is released and casked
