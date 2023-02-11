"                         _                     "
"   ___  _ __   _____   _(_)_ __ ___  _ __ ___  "
"  / _ \| '_ \ / _ \ \ / / | '_ ` _ \| '__/ __| "
" | (_) | | | |  __/\ V /| | | | | | | | | (__  "
"  \___/|_| |_|\___(_)_/ |_|_| |_| |_|_|  \___| "
"                                               "
" * Pre Init: {{{
set nocompatible
syntax off
filetype plugin indent off
let $MYVIMRC = expand('<sfile>')
" * }}}
" * General: {{{
" * * Encoding: {{{
set fileformat=unix
set fileformats=unix,dos
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,cp932,euc-jp
" * * }}}
" * * Clipboard: {{{
set clipboard+=unnamed
set clipboard+=unnamedplus
" * * }}}
" * * Control: {{{
set mouse=a
set whichwrap=b,s,<,>,[,]
set timeout
set timeoutlen=2000
set ttimeoutlen=-1
" * * }}}
" * * Help: {{{
set helpheight&vim
set helplang=ja
" * * }}}
" * * FileType: {{{
augroup filetype_settings
  au BufNewFile,BufRead *.vim   set filetype=vim
  au BufNewFile,BufRead *.vimrc set filetype=vim
  au BufNewFile,BufRead *.c     set filetype=c
  au BufNewFile,BufRead *.js    set filetype=javascript
  au BufNewFile,BufRead *.py    set filetype=python
  au BufNewFile,BufRead *.sh    set filetype=sh
  au BufNewFile,BufRead *.bash  set filetype=sh
  au BufNewFile,BufRead *.ash   set filetype=sh
augroup END
" * * }}}
" * }}}
" * Editing: {{{
" * *  Searching: {{{
set incsearch
set ignorecase
set smartcase
"set hlsearch
" * * }}}
" * * Command-Line: {{{
set wildmenu
set wildmode=longest:list,full
" * * }}}
" * * Modifying: {{{
set backspace=indent,eol,start
" * * }}}
" * * Indent: {{{
set expandtab
set ts=4
set sts=-1 sw=0
set autoindent
set smartindent
" * * * FileType Indent: {{{
" ref: https://qiita.com/ysn/items/f4fc8f245ba50d5fb8b0
augroup filetype_indent_settings
  au FileType vim    setl et   ts=2 sts=-1 sw=0
  au FileType c      setl noet ts=4 sts=-1 sw=0 cindent
  au FileType js     setl noet ts=4 sts=-1 sw=0
  au FileType python setl et   ts=4 sts=-1 sw=0
  au FileType sh     setl et   ts=2 sts=-1 sw=0
augroup END
" * * * }}}
" * * }}}
" * }}}
" * Appearance: {{{
set number
set cursorline
set showcmd
set showmatch
if has('termguicolors') && !has('gui_running')
  set termguicolors
endif
set ambiwidth=single
" * * ListChars: {{{
set list
set listchars=
set listchars+=tab:>\ 
set listchars+=trail:~
set listchars+=nbsp:%
"set listchars+=eol:$
set listchars+=extends:»
set listchars+=precedes:«
"set listchars+=space:·
" * * }}}
" * * StatusLine: {{{
set laststatus=2
set ruler
set showmode
" * * }}}
" * * Foldtext: {{{
function! MyFoldText() abort
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 5
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . '..' . foldedlinecount  . ' '
endfunction 
set foldtext=MyFoldText()
" * * }}}
" * }}}
" * Key Mapping: {{{
let mapleader = "\<Space>"
" * Misc: {{{
inoremap <silent>jk <Esc>

nnoremap j gj
nnoremap k gk

nnoremap H ^
nnoremap L $
nnoremap J 3j
nnoremap K 3k

nnoremap U <C-r>
nnoremap <C-r> U

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nnoremap <Space><Space> :setl relativenumber!<CR>

nnoremap <Leader>h :<C-u>set hlsearch!<CR>

inoremap <C-Tab> <Tab>
" * * Misc: }}}
" * * [window]: {{{
nmap <Leader>w [window]
noremap [window] <Nop>
nnoremap [window]h <C-w>h
nnoremap [window]j <C-w>j
nnoremap [window]k <C-w>k
nnoremap [window]l <C-w>l
nnoremap [window]s :<C-u>split<CR>
nnoremap [window]v :<C-u>vsplit<CR>
nnoremap [window]o :<C-u>only<CR>
" * * }}}
" * * [tab]: {{{
nmap <Leader>t [tab]
nnoremap [tab] <Nop>
nnoremap [tab]h :<C-u>tabprevious<CR>
nnoremap [tab]l :<C-u>tabnext<CR>
nnoremap [tab]n :<C-u>tabnew<CR>
" * * }}}
" * * [terminal]: {{{
nmap <Leader>x [terminal]
nnoremap [terminal] <Nop>

nnoremap [terminal]h :<C-u>vertical aboveleft terminal<CR>
nnoremap [terminal]j :<C-u>rightbelow terminal<CR>
nnoremap [terminal]k :<C-u>aboveleft terminal<CR>
nnoremap [terminal]l :<C-u>vertical rightbelow terminal<CR>

nnoremap [terminal]H :<C-u>vertical topleft terminal<CR>
nnoremap [terminal]J :<C-u>botright terminal<CR>
nnoremap [terminal]K :<C-u>topleft terminal<CR>
nnoremap [terminal]L :<C-u>vertical botright terminal<CR>

nnoremap [terminal]t :<C-u>tab terminal<CR>
" * * }}} 
" * * [vimrc]: {{{
nmap <Leader>v [vimrc]
nnoremap [vimrc] <Nop>
nnoremap [vimrc]s :<C-u>source $MYVIMRC<CR>
nnoremap [vimrc]e :<C-u>edit $MYVIMRC<CR>
nnoremap [vimrc]t :<C-u>tabnew $MYVIMRC<CR>
" * * }}}
" * * [comment]: {{{
function InsertCommentString()
  let line = getline('.')
  let lineNum = line('.')
  call setline(lineNum, printf(&cms, line))
endfunction

function! CommentIn() abort
  " ref: https://vim-jp.org/vim-users-jp/2009/09/20/Hack-75.html
  " \%(^\s*\|^\t*\)\@<=\S
  let l = getline('.')
  if l == ''
    call setline(line('.'), printf(&cms, ''))
  else
    call setline(line('.'), substitute(getline('.'), '\%(^\s*\|^\t*\)\@<=\(\S.*\)', printf(&cms, '\1'), ''))
    "echo substitute(getline('.'), '\%(^\s*\|^\t*\)\@<=\(\S.*\)', '" \1', '')
  endif
endfunction

function CommentOut() abort
  let l = getline('.')
  if l == printf(&cms, '')
    call setline(line('.'), '')
  else
    "echo substitute(getline('.'), printf(&cms, ''), '', '')
    call setline(line('.'), substitute(getline('.'), printf(&cms, ''), '', ''))
  endif
endfunction

nmap <Leader>c [comment]
nnoremap [comment] <Nop>
nnoremap [comment]i :call CommentIn()<CR>
nnoremap [comment]o :call CommentOut()<CR>
"nnoremap <expr>[comment] I<C-r>=printf(&cms, '')<CR><Esc>
" * * }}}
" *  }}}
" * Post Init: {{{
syntax enable
set background=dark
colorscheme desert
filetype plugin indent on
" * }}}
" vim: set ft=vim ts=2 sts=-1 sw=0 et ai si fdm=marker cms="\ %s:

