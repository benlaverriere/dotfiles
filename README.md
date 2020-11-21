# dotfiles

Ensure that `git` is installed locally.

Create `~/.gitconfig_local` with contents like:

```
[user]
  name = "Ben LaVerriere"
  email = benlaverriere@example.com
```

[Install Homebrew](https://brew.sh/) so that we can install other software.

Run `script/bootstrap.sh` to set everything up for the first time.
Thereafter, run `[bundle exec] rake fix` to update things.

## resources

- [Vim 8 native package management](https://shapeshed.com/vim-packages/)
  - You probably want `g submodule add <git URL> vim/.vim/pack/benlaverriere/start/<name>`


## TODO

- replace TeXShop with standalone TeXLive
- figure out distinction between Rake and `stow_it_all` tasks, or combine

## QMK

- `qmk configure` and `qmk flash`
- Using a weekly build of Plover until 4.0 is released and casked
