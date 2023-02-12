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
" * Plugin: {{{
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_sizestyle = 'H'
let g:netrw_timefmt = '%Y-%m-%dT%H:%M:%S'
let g:netrw_winsize = 25
" https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
endfunction
" * }}}
" * General: {{{
set shellslash
set novisualbell
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
set hidden
" * * Searching: {{{
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
if has('termguicolors') && !has('gui_running') && 1
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
" * * FillChars: {{{
set fillchars+=vert:┃ " U+2503
" * * }}}
" * * StatusLine: {{{j
set laststatus=2
set ruler
set showmode
" baased on https://github.com/KaraMCC/vim-streamline/tree/master/plugin
" license: https://github.com/KaraMCC/vim-streamline/blob/master/LICENSE
set laststatus=2
set statusline=%!CreateStatusline()
augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!CreateStatusline()
  autocmd WinLeave * setlocal statusline=%!CreateInactiveStatusline()
augroup END

" function! GetBufSize() abort
  " let l:bufbytes = wordcount().bytes
  " echo l:bufbytes
" endfunction

function! CreateStatusline() abort
  let statusline=''
  let statusline.='%#Search#'
  let statusline.=' %{GetMode()} '
  let statusline.='%#diffadd#'
  let statusline.='%#CursorlineNr#'
  let statusline.=' %y'              " Show filetype
  let statusline.=' %f'                  " Show filename
  let statusline.=' %m'                  " Show modified tag
  let statusline.='%='                   " Switch elements to the right
  if !get(g:, 'streamline_minimal_ui', 0)
    let statusline.='%{&fileencoding?&fileencoding:&encoding}'
    let statusline.=' %{&fileformat} '
    let statusline.='%#TermCursor#'
    let statusline.='▏'
  endif
  let statusline.='c%{wordcount().chars} '
  let statusline.='%l:%c'              " Show line number and column
  let statusline.=' %p%% '               " Show percentage
  return statusline
endfunction

function! CreateInactiveStatusline()
  let statusline=''
  let statusline.='%#Whitespace#'
  let statusline.=' %{GetMode()} '
  let statusline.='▏'
  let statusline.=' %y'
  let statusline.=' %f'
  let statusline.=' %m'
  let statusline.='%='
  if !get(g:, 'streamline_minimal_ui', 0)
    let statusline.='%{&fileencoding?&fileencoding:&encoding}'
    let statusline.=' %{&fileformat} '
    let statusline.='▏'
  endif
  let statusline.='%l:%c'
  let statusline.=' %p%% '
  return statusline
endfunction

function! GetMode()
  let l:mode=mode(1)
  if l:mode ==# 'i'
    return 'INSERT'
  elseif l:mode ==# 'c'
    return 'COMMAND'
  elseif l:mode ==# 'v'
    return 'VISUAL'
  elseif l:mode ==# 'V'
    return 'V-LINE'
  elseif l:mode ==# "\<C-V>"
    return 'V-BLOCK'
  elseif l:mode ==? 'R' || l:mode ==? 'Rv'
    return 'REPLACE'
  elseif l:mode ==? 't'
    return 'TERMINAL'
  else
    return 'NORMAL'
  endif
endfunction

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
" * * Misc: {{{
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

nnoremap <silent> <Space><Space> :<C-u>setl relativenumber!<CR>:<C-u>setl relativenumber?<CR>

nnoremap <Leader>h :<C-u>set hlsearch!<CR>

nnoremap x "_x

inoremap <C-Tab> <Tab>
" * * Misc: }}}
" * * [explorer](netrw): {{{
nmap <leader>e [explorer]
nnoremap [explorer] <Nop>
nnoremap <silent> [explorer]e :<C-u>call ToggleVExplorer()<CR>
" * * }}}
" * * [buffer]: {{{
nmap <Leader>b [buffer]
nnoremap [buffer] <Nop>
nnoremap [buffer]p :<C-u>bprev<CR>
nnoremap [buffer]k :<C-u>bprev<CR>
nnoremap [buffer]n :<C-u>bnext<CR>
nnoremap [buffer]j :<C-u>bnext<CR>
" * * }}}
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
" * }}}
" * Post Init: {{{
syntax enable
set background=dark
" colorscheme desert
colorscheme slate
filetype plugin indent on
" * }}}
" vim: set ft=vim ts=2 sts=-1 sw=0 et fdm=marker fmr={{{,}}} cms="\ %s:

