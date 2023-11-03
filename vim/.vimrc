autocmd!

" Basics
filetype plugin indent on
syntax on
set omnifunc=syntaxcomplete#Complete
inoremap jk <ESC>
let mapleader = " "
set mouse=a

augroup FileTypes
  autocmd!
  au BufRead,BufNewFile *.md set filetype=markdown
  au BufRead,BufNewFile *.todo set filetype=markdown
  au BufRead,BufNewFile *.thor set filetype=ruby
  au BufRead,BufNewFile Podfile set filetype=ruby
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
" ideally just want $(brew --prefix) here
set rtp+=/usr/local/opt/fzf
set rtp+=/opt/homebrew/opt/fzf
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

" Wrap (vim defaults this on, but just to be explicit) and do so at word boundaries
set wrap linebreak

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
packadd! matchit
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" Syntax highlighting requires Solarized, so after `packloadall`
set termguicolors
if $TERM == "xterm-kitty"
  " vim only sets these correctly, automatically, for $TERM = xterm
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
end
set background=dark
colorscheme solarized8_flat

let g:ale_fix_on_save = 1
let g:ale_linters_ignore = {'tex': ['lacheck']}
nnoremap <leader>ale :call ToggleALEAutofix()<cr>
function! ToggleALEAutofix()
    if g:ale_fix_on_save
        let g:ale_fix_on_save = 0
        echom "ALE fix on save OFF"
    else
        let g:ale_fix_on_save = 1
        echom "ALE fix on save ON"
    endif
endfunction

" Navigate between ALE errors quickly
" TODO understand why nnoremap doesn't work for these
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" color customizations
if has('nvim')
  highlight Search gui=underdot cterm=underline
  highlight Comment guisp=italic cterm=italic
  highlight SpellBad cterm=undercurl guisp=nocombine,undercurl
else
  highlight Search gui=underline cterm=underline
  highlight Comment cterm=italic
endif

highlight link TK ALEError
match TK /TK/

" limelight + goyo = focused text editing
nnoremap <leader>gy :Goyo<cr>
let g:goyo_width=130
let g:limelight_conceal_ctermfg=10
augroup Limelight
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END

" Things from Learn Vimscript the Hard Way
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

if has('nvim')
  nnoremap <leader>evv :split ~/.vimrc<cr>
  nnoremap <leader>svv :source ~/.vimrc<cr>
endif

iabbrev kf Kingfisher
iabbrev mj Mockingjay
iabbrev zz zazu
iabbrev bl benlaverriere
iabbrev ae AudioEngine
iabbrev lv LaVerriere
iabbrev rn React Native
iabbrev cv question

nnoremap H ^
nnoremap L $

noremap <Left> <nop>
noremap <Right> <nop>

" Searches:
" g for "grep", whatever's currently my preference (while adjusting to rg)
nnoremap <leader>g :Rg<cr>
nnoremap <leader>ag :Ag<cr>
nnoremap <leader>rg :Rg<cr>
" Rg current word (https://github.com/junegunn/fzf.vim/issues/714)
nnoremap <silent> <Leader>gg :Rg <C-R><C-W><CR>
" fzf search of open files
nnoremap <leader>ww :Windows<cr>

nnoremap <leader>h :nohlsearch<cr>
" find git merge conflicts
nnoremap <leader>mg /\(<<<<<<<\\|>>>>>>>\\|=======\)<cr>zz

nmap <Leader>m <Plug>ToggleMarkbar
if has('nvim')
      set shada+=!
else
      set viminfo+=!
endif

augroup typescript
  " by default, typescript-vim runs tsc on the current file, which apparently means ignoring tsconfig.json
  autocmd FileType typescript :set makeprg=tsc
augroup END

" Spelling
nnoremap <leader>s :setlocal spell! spelllang=en_us<cr>
