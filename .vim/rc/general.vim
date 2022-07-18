" encodings
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" Use the OS clipboard
set clipboard=unnamed

set mouse=a

" ref:https://github.com/vim-jp/issues/issues/1242
set ttymouse=sgr

set wildmenu

set backspace=indent,eol,start

set ignorecase

set smartcase

" Allow buffer switching without saving
set hidden

set autochdir

filetype plugin indent on

set backupdir=~/.vim/backups

set directory=~/.vim/swaps

" Save undos after file closed
set undofile

set undodir=~/.vim/undo

" How many undos
set undolevels=1000
