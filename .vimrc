set ai nu smd sw=4 ts=4

if has('syntax')
  syntax on
endif
filetype plugin indent on

set backspace=indent,eol,start
set clipboard=
set expandtab
set guicursor=
set keymodel=startsel,stopsel
set noincsearch
set mouse=nvi
set mousemodel=popup_setpos
set ruler
set shiftround
set showcmd
set selection=exclusive
set splitbelow
set splitright
set termguicolors

set background=dark
highlight! link LineNr Normal
highlight! link StatusLine ModeMsg
highlight! link StatusLineNC Normal

set t_ti=
set t_te=[0\ q

autocmd BufNewFile,BufRead .shrc set filetype=sh
autocmd FileType go,make,sh set noexpandtab
autocmd FileType js,json set sw=2 ts=2

map ` ~
