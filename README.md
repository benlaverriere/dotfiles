# dotfiles

Ensure that `git` is installed locally.

Update submodules in this repository (used for Vim plugin management).
After first checking out this repo to a new machine, include `--init`.
From then on, you can omit it.
 
    $ g[it] submodule update [--init] --remote --merge

[Install Homebrew](https://brew.sh/) so that we can install other software.
The Brewfile in this repository lists these packages.

    $ brew bundle --file=Brewfile

Specify Homebrew's zsh (installed already from `Brewfile`) per [these
instructions](https://stackoverflow.com/a/17649823), with credit to [this answer](https://stackoverflow.com/a/3557165):

    $ ./setup/switch_zsh.sh

Finally, use `stow` to symlink the config directories in this repository to your home directory.

    $ stow zsh [and/or stow bash]
    $ stow shared_shell
    $ stow git
    $ stow tmux
    $ stow vim

## resources

- [Vim 8 native package management](https://shapeshed.com/vim-packages/)

## TODO

- add iTerm2 preferences
- add JetBrains Mono
- replace TeXShop with standalone TeXLive
