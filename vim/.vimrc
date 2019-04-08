filetype plugin indent on
syntax on

set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

set number
set numberwidth=5

set formatoptions=croqln
set textwidth=120
au FileType gitcommit set textwidth=72

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.gitcommit set filetype=gitcommit

set colorcolumn=+1

set ignorecase smartcase
set hlsearch

set laststatus=2
