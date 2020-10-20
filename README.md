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
Thereafter, run `script/beer_run.rb` to update things.

## resources

- [Vim 8 native package management](https://shapeshed.com/vim-packages/)
  - You probably want `g submodule add <git URL> vim/.vim/pack/benlaverriere/start/<name>`


## TODO

- replace TeXShop with standalone TeXLive

## QMK

- run `qmk setup benlaverriere/qmk_firmware` to get things ready
- QMK's config lives in `~/Library/Application Support/qmk/qmk.ini` --- `stow` it?
  - sample copy in root of this repo
- `qmk configure` and `qmk flash`
