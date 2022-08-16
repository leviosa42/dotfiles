" ===================================
"   VARIABLES
" ===================================
let g:custom_background = 'dark'
let g:custom_colorscheme = 'default'
let g:custom_guifont = 'HackGen\ Console:h13'

" ===================================
"   GENERAL
" ===================================
set runtimepath^=~/.vim
set packpath^=~/.vim
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
set clipboard=unnamed
set mouse=a
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start
set ignorecase
set smartcase
set hidden
set autochdir
set cindent
set noexpandtab
set tabstop=4
set softtabstop=-1
set shiftwidth=0

" ===================================
"   APPEARANCE
" ===================================
syntax on
execute 'colorscheme ' . g:custom_colorscheme
execute 'set background=' . g:custom_background
set number
"set relativenumber
set cursorline
set showmatch
set showmode
set laststatus=2
set ruler
set list
set listchars=tab:▶\ ,trail:-,nbsp:␣,extends:»,precedes:«
set showcmd
set cmdheight=2
set tabstop=4
set noexpandtab
set smartindent

" ===================================
"   GUI
" ===================================
execute 'set guifont=' . g:custom_guifont

" ===================================
"   PLUGINS
" ===================================
let g:netrw_dirhistmax = 0