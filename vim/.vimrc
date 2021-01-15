" remember: `:so[urce] ~/.vimrc` to reload, or `:so %` while editing
autocmd!

" Basics
filetype plugin indent on
syntax on
set omnifunc=syntaxcomplete#Complete
inoremap jk <ESC>
let mapleader = " "

augroup FileTypes
  autocmd!
  au BufRead,BufNewFile *.md set filetype=markdown
  au BufRead,BufNewFile *.thor set filetype=ruby
  au BufRead,BufNewFile *.gitcommit set filetype=gitcommit
  au BufRead,BufNewFile Fastfile set filetype=ruby
  au BufRead,BufNewFile Matchfile set filetype=ruby
  au BufRead,BufNewFile Pluginfile set filetype=ruby
  au BufRead,BufNewFile Scanfile set filetype=ruby
augroup END

" file browsing
" notable kudos to https://www.youtube.com/watch?v=XA2WjJbmmoM
set path+=**
set wildmenu
set rtp+=/usr/local/opt/fzf
nnoremap <leader>f :Files<CR>

" fzf's :Ag matches filenames by default.
" from the author, via https://github.com/junegunn/fzf.vim/issues/346#issuecomment-288483704 :
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

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
hi CursorLine cterm=bold ctermfg=NONE ctermbg=5
set cursorline!

" Width/column
set textwidth=120
set colorcolumn=+1

" Searching
set ignorecase smartcase
set hlsearch
set incsearch

set laststatus=2
set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)\ %{gutentags#statusline('[',']')}

" vimtex needs this to be defined globally
let g:tex_flavor = 'latex'

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" Syntax highlighting requires Solarized, so after `packloadall`
set background=dark
colorscheme solarized

let g:ale_fix_on_save = 1

" Navigate between ALE errors quickly
" TODO understand why nnoremap doesn't work for these
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" color customizations
highlight Search gui=underline cterm=underline
highlight ALEError ctermbg=Red

" limelight + goyo = focused text editing
let g:limelight_conceal_ctermfg=10
augroup Limelight
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END

" Things from Learn Vimscript the Hard Way
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

iabbrev kf Kingfisher
iabbrev mj Mockingjay
iabbrev zz zazu
iabbrev bl benlaverriere
iabbrev ae AudioEngine
iabbrev lv LaVerriere
iabbrev rn React Native

nnoremap H ^
nnoremap L $

noremap <Left> <nop>
noremap <Right> <nop>

nnoremap <leader>a :Ag<cr>
nnoremap <leader>h :nohlsearch<cr>
" find git merge conflicts
nnoremap <leader>m /\(<<<<<<<\\|>>>>>>>\\|=======\)<cr>zz
