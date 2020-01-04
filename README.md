# dotfiles

Ensure that `git` is installed locally.

Update submodules in this repository (used for Vim plugin management).
After first checking out this repo to a new machine, include `--init`.
From then on, you can omit it.
 
    $ g[it] submodule update [--init] --remote --merge

[Install Homebrew](https://brew.sh/) so that we can install other software.
The Brewfile in this repository lists these packages.

    $ brew bundle --file=Brewfile

Finally, use `stow` to symlink the config directories in this repository to your home directory.

    $ stow zsh [and/or stow bash]
    $ stow shared_shell
    $ stow git
    $ stow tmux
    $ stow vim

## resources

- [Vim 8 native package management](https://shapeshed.com/vim-packages/)
