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

## TODO

- replace TeXShop with standalone TeXLive
