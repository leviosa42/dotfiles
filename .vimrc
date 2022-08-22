set nocompatible
filetype plugin indent off

" ===================================
"   VARIABLES
" ===================================
let g:custom_background = 'dark'
let g:custom_colorscheme = 'default'
let g:custom_guifont = 'HackGen\ Console:h13'
if executable('git')
  let g:jetpack_download_method = 'git'
elseif execuable('curl')
  let g:jetpack_download_method = 'curl'
elseif execuable('wget')
  let g:jetpack_download_method = 'wget'
endif

" ===================================
"   GENERAL
" ===================================
set runtimepath^=~/.vim
set packpath^=~/.vim
set fileformat=unix
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
set clipboard=unnamed
set mouse=a
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set ignorecase
set smartcase
set hidden
set autochdir

" indent
set noexpandtab
set tabstop=4
set softtabstop=-1
set shiftwidth=0
set autoindent
set smartindent
" ref: https://qiita.com/ysn/items/f4fc8f245ba50d5fb8b0
augroup filetype_indent_settings
    au FileType vim          setl et   ts=2 sts=-1 sw=0
    au FileType c            setl noet ts=4 sts=-1 sw=0 cindent
    au FileType javascript   setl noet ts=4 sts=-1 sw=0
    au FileType python       setl et   ts=4 sts=-1 sw=0
    au FileType sh           setl et   ts=2 sts=-1 sw=0
augroup END

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
set listchars=tab:▶\ ,trail:-,nbsp:␣,extends:»,precedes:«,space:·
set showcmd
set cmdheight=2
set tabstop=4
set noexpandtab
set smartindent

" ===================================
"   GUI
" ===================================
execute 'set guifont=' . g:custom_guifont
set guioptions-=T
if has('iVim')
  source ~/.vim/ekbd.vim
endif

" ===================================
"   PLUGINS
" ===================================
if has('iVim')
"  iplug import ~/.vim/iplug.json
else
  runtime */jetpack.vim
  call jetpack#begin()
  Jetpack 'tani/vim-jetpack', {'opt': 1 }
  Jetpack 'tomasr/molokai'
  Jetpack 'itchyny/lightline.vim'
  Jetpack 'vim-jp/vimdoc-ja'
  call jetpack#end()
endif

let g:netrw_dirhistmax = 0
let g:lightline = {
  \ 'colorscheme': 'molokai'
  \ }
if has('iVim')
  let g:lightline.component = {
    \ 'mode': '%{g:lightline#mode()[0]}'
    \ }
endif  

colorscheme molokai

filetype plugin indent on