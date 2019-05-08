filetype plugin indent on
syntax on

set backspace=indent,eol,start

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

" Don't try to run lacheck on [La]TeX
let g:ale_linters = {
\   'tex': ['alex', 'chktex', 'proselint', 'redpen', 'textlint', 'vale', 'writegood'],
\}

" Navigate between ALE errors quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ALE color customizations
highlight ALEWarning ctermbg=Green
highlight ALEError ctermbg=Red
