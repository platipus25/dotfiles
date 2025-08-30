" Use the Elflord theme
set background=dark
colorscheme slate

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Add the g flag to search/replace by default
set gdefault

" Enable syntax highlighting
syntax on

" Make tabs as wide as two spaces
set tabstop=2
set shiftwidth=2

" Use spaces instead of tabs
set expandtab

set ai "Auto indent
set si "Smart indent

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Enable mouse in all modes
set mouse=a

" Fix mouse in alacritty
if $TERM == 'alacritty'
  set ttymouse=sgr
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


" Add maktaba and bazel to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'


Plug 'rhysd/vim-clang-format'

Plug 'jremmen/vim-ripgrep'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'

Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }

" Initialize plugin system
call plug#end()

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><C-K> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><C-K> <c-o>:ClangFormat<CR>
autocmd FileType c,cpp,objc inoremap <buffer><C-K> <esc>:ClangFormat<CR>a

function! Formatonsave()
  let l:formatdiff = 1
  :ClangFormat
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

autocmd FileType c ClangFormatAutoEnable

:inoremap jk <esc>

syntax enable
filetype plugin indent on

let g:rustfmt_autosave = 1

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitespace except when typing at the end of the line
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" Show trailing whitespace:
:au InsertLeave * match ExtraWhitespace /\s\+$/
" Delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

set rtp+=/usr/local/opt/fzf

" General colors
if has('gui_running') || has('nvim')
    hi Normal 		guifg=#ffffff guibg=#1a1d21
else
    " Set the terminal default background and foreground colors, thereby
    " improving performance by not needing to set these colors on empty cells.
    hi Normal guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE
    let &t_ti = &t_ti . "\033]10;#ffffff\007\033]11;#1a1d21\007"
    let &t_te = &t_te . "\033]110\007\033]111\007"
endif
