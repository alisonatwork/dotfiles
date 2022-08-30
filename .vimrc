set ai nu smd sw=4 ts=4

if has('syntax')
  syntax on
endif
filetype plugin indent on

set backspace=indent,eol,start
set clipboard=
set expandtab
set noincsearch
set ruler
set shiftround
set showcmd

if has('gui_running')
  set guioptions-=T
  set guifont=Consolas:h10
  set lines=43 columns=132 linespace=0
  colorscheme desert
endif

set t_ti= t_te=

autocmd BufNewFile,BufRead .shrc set filetype=sh
autocmd FileType go,make,sh set noexpandtab
autocmd FileType js,json set sw=2 ts=2

map ` ~

