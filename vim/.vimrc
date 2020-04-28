" remember: `:so[urce] ~/.vimrc` to reload, or `:so %` while editing
autocmd!
set nocompatible

" Filetype/syntax
filetype plugin indent on
syntax on
set omnifunc=syntaxcomplete#Complete

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.gitcommit set filetype=gitcommit
au BufRead,BufNewFile Fastfile set filetype=ruby
au BufRead,BufNewFile Matchfile filetype=ruby
au BufRead,BufNewFile Pluginfile set filetype=ruby

" file browsing
" notable kudos to https://www.youtube.com/watch?v=XA2WjJbmmoM
set path+=**
set wildmenu
set rtp+=/usr/local/opt/fzf

" General editing
set backspace=indent,eol,start
set formatoptions=croqln

set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

" Line numbers
set number
set relativenumber
set numberwidth=5

" Cursor position
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE
set cursorline!
"hi CursorColumn cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE
"autocmd InsertEnter,InsertLeave * set cursorline! cursorcolumn!

" Width/column
set textwidth=120
set colorcolumn=+1

" Searching
set ignorecase smartcase
set hlsearch

set laststatus=2

" options for vim-javascript
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_function             = "ƒ"
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" Navigate between ALE errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ALE color customizations
highlight ALEWarning ctermbg=Green
highlight ALEError ctermbg=Red
