set ai nu smd sw=4 ts=4

silent! call pathogen#infect()
syntax on
filetype plugin indent on

set backspace=indent,eol,start
set expandtab
set ruler
set showcmd

if has('gui_running')
  set guioptions-=T
  set guifont=Consolas:h10
  set lines=43 columns=132 linespace=0
  colorscheme desert
endif

