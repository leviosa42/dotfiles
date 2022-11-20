" ===================================
" filename: .vimrc
" author  : leviosa42
" license : MIT license
" ===================================

" Vi Improved
set nocompatible

" ===================================
"   VARIABLES
" ===================================
function! s:gethome() abort
  let l:term_program = expand('$TERM_PROGRAM')
  "let l:original_home = expand('$HOME')
  if term_program == 'a-Shell'
    return expand('~/Documents')
  else
    return expand('~')
  endif
endfunction
let g:custom_home = s:gethome()
"let g:custom_colorscheme = 'elflord'
let g:custom_colorscheme = 'molokai'
let g:custom_background = 'dark'
let g:custom_guifont = 'HackGen\ Console:h13'
let g:custom_default_use_softtab = 1
let g:custom_indent_width = 4
let mapleader = "\<Space>"

let g:session_directory = g:custom_home.'/.vimlocal/sessions'

let g:netrw_home = g:custom_home.'/.vimlocal'

" ===================================
"   GENERAL
" ===================================
execute 'set packpath^=' . g:custom_home . '/.vimlocal'
execute 'set runtimepath^=' . g:custom_home . '/.vimlocal'

set helplang=ja,en
" Encodings
set fileformat=unix
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp

set clipboard+=unnamed
set clipboard+=unnamedplus

set mouse=a

set whichwrap=b,s,h,l,<,>,[,]
set timeout
set timeoutlen=2000
set ttimeoutlen=10
if has('termguicolors')
  set termguicolors
endif
set t_Co=256
syntax on

filetype plugin indent off

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

augroup folding_setting
  au FileType vim setl foldmethod=marker
augroup END

" ===================================
"   EDITING
" ===================================

set incsearch
set ignorecase
set smartcase
"set hlsearch
set wildmenu
set wildmode=longest:list,full
set autochdir
set backspace=indent,eol,start

" indent
if g:custom_default_use_softtab
  set expandtab
else
  set noexpandtab
endif
execute 'set tabstop=' . g:custom_indent_width
set softtabstop=-1
set shiftwidth=0
set autoindent
set smartindent
" ref: https://qiita.com/ysn/items/f4fc8f245ba50d5fb8b0
augroup filetype_indent_settings
  au FileType vim    setl et   ts=2 sts=-1 sw=0
  au FileType c      setl noet ts=4 sts=-1 sw=0 cindent
  au FileType js     setl noet ts=4 sts=-1 sw=0
  au FileType python setl et   ts=4 sts=-1 sw=0
  au FileType sh     setl et   ts=2 sts=-1 sw=0
augroup END

" ===================================
"   APPEARANCE
" ===================================
set number
set ruler
set cursorline
set showcmd
set showmatch
set showcmd
set noshowmode
set list
set listchars=   " init
set listchars+=tab:>\ 
set listchars+=trail:~
set listchars+=nbsp:%
"set listchars+=eol:$
set listchars+=extends:»
set listchars+=precedes:«
"set listchars+=space:·

let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"

" ===================================
"  STATUSLINE
" ===================================
set laststatus=2
let g:custom_stl_config = {
  \ 'highlight': {
    \ 'normal': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkgreen',
      \ 'gui': 'gui=bold guifg=white guibg=darkgreen'
      \ },
    \ 'visual': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkmagenta',
      \ 'gui': 'gui=bold guifg=white guibg=darkmagenta'
      \ },
    \ 'select': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=brown',
      \ 'gui': 'gui=bold guifg=white guibg=brown'
      \ },
    \ 'insert': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=blue',
      \ 'gui': 'gui=bold guifg=white guibg=blue'
      \ },
    \ 'replace': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkred',
      \ 'gui': 'gui=bold guifg=white guibg=darkred'
      \ },
    \ 'command': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkgreen',
      \ 'gui': 'gui=bold guifg=white guibg=darkgreen'
      \ },
    \ 'prompt': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkgreen',
      \ 'gui': 'gui=bold guifg=white guibg=darkgreen'
      \ },
    \ 'execute': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkgreen',
      \ 'gui': 'gui=bold guifg=white guibg=darkgreen'
      \ },
    \ 'terminal': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkcyan',
      \ 'gui': 'gui=bold guifg=white guibg=darkcyan'
      \ },
    \ 'inactive': {
      \ 'cterm': 'cterm=bold ctermfg=white ctermbg=darkgray',
      \ 'gui': 'gui=bold guifg=white guibg=darkgray'
      \ },
    \ },
  \ 'mode_name': {
    \ 'n': ['N', 'NORMAL'],
    \ 'v': ['V', 'VISUAL'],
    \ 'V': ['VL', 'V-LINE'],
    \ "\<C-v>": ['VB', 'V-BLOCK'],
    \ 's': ['S', 'SELECT'],
    \ 'S': ['SL', 'S-LINE'],
    \ "\<C-s>": ['SB', 'S-BLOCK'],
    \ 'i': ['I', 'INSERT'],
    \ 'R': ['R', 'REPLACE'],
    \ 'c': ['C', 'COMMAND'],
    \ 'r': ['P', 'PROMPT'],
    \ '!': ['E', 'EXECUTE'],
    \ 't': ['T', 'TERMINAL']
    \ }
  \ }

let g:customline = {}

function g:customline.CreateStatusLine(is_active) abort
  let stl = ''
  if a:is_active
    let stl .= '%#' . g:customline.GetModeHighlightName() .'#'
    let stl .= ' %{g:customline.GetModeName()} '
    let stl .= '%#StatusLine#'
    let stl .= '%f'
    let stl .= '%m'
    let stl .= '%h'
    let stl .= '%w'
    let stl .= '%w'
    let stl .= '%<'
    let stl .= '%r'
    let stl .= '%='
    if winwidth(0) > 70
      let stl .= '%#CursorLine#'
      let stl .= ' %{&fenc?&fenc:&enc}'
      let stl .= ' %{&ff}'
      let stl .= ' %{&ft}'
    endif
    let stl .= ' '
    let stl .= '%#' . g:customline.GetModeHighlightName() .'#'
    let stl .= ' %c:%l '
  else
    let stl .= '%#CustomLine_inactive#'
    let stl .= ' %{g:customline.GetModeName()} '
    let stl .= '%#StatusLineNC#'
    let stl .= '%f'
    let stl .= '%m'
    let stl .= '%h'
    let stl .= '%w'
    let stl .= '%w'
    let stl .= '%<'
    let stl .= '%r'
    let stl .= '%='
    if winwidth(0) > 70
      let stl .= ' %{&fenc?&fenc:&enc}'
      let stl .= ' %{&ff}'
      let stl .= ' %{&ft}'
    endif
    let stl .= ' '
    let stl .= '%#' . g:customline.GetModeHighlightName() .'#'
    let stl .= '%#CustomLine_inactive#'
    let stl .= ' %c:%l '
  endif
  return stl
endfunction

function g:customline.Init() abort
  " highlight
  let hi_dict = g:custom_stl_config['highlight']
  for mt in keys(hi_dict)
    exec printf('hi CustomLine_%s %s', mt, hi_dict[mt]['cterm'])
    exec printf('hi CustomLine_%s %s', mt, hi_dict[mt]['gui'])
  endfor
endfunction

function g:customline.GetModeType() abort
  let dict = {
    \ 'n': 'normal',
    \ 'v': 'visual',
    \ 'V': 'visual',
    \ "\<C-v>": 'visual',
    \ 's': 'select',
    \ 'S': 'select',
    \ "\<C-s>": 'select',
    \ 'i': 'insert',
    \ 'R': 'replace',
    \ 'c': 'command',
    \ 'r': 'prompt',
    \ '!': 'execute',
    \ 't': 'terminal'
    \ }
  return get(dict, mode(0))
endfunction

function g:customline.GetModeHighlightName() abort
  let mode_type = g:customline.GetModeType()
  return 'CustomLine_' . mode_type
endfunction

function g:customline.GetModeName() abort
  let name_dict = g:custom_stl_config['mode_name']
  let use_longname = winwidth(0) > 70
  return get(name_dict, mode(0), ['NF', 'NOTFOUND'])[use_longname]
endfunction

augroup customline
  autocmd!
  autocmd ColorScheme * call g:customline.Init()
  autocmd WinEnter,BufEnter * setl stl=%!g:customline.CreateStatusLine(1)
  autocmd WinLeave,BufLeave * setl stl=%!g:customline.CreateStatusLine(0)
augroup END
set statusline=%!g:customline.CreateStatusLine(1)

" ===================================
"   PLUGINS
" ===================================
if g:custom_enable_pluginmanager
  " bootstrap
  let s:jetpackfile = g:custom_home . '/.vimlocal/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
  let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
  if !filereadable(s:jetpackfile)
    call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
  endif
  "plugins
  "runtime */jetack.vim
  packadd vim-jetpack
  call jetpack#begin(g:custom_home . '/.vimlocal')
  call jetpack#add('tani/vim-jetpack', {'opt': 1})
  call jetpack#add('vim-jp/vimdoc-ja')
  call jetpack#add('itchyny/lightline.vim', {'start': 1})
  call jetpack#end()
endif

" ===================================
"   KEYBINDINGS
" ===================================
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj

"inoremap { {}<Left>
"inoremap [ []<Left>
"inoremap ( ()<Left>
"inoremap ' ''<Left>
"inoremap " ""<Left>

nnoremap <Leader>e :e .<CR>
nnoremap <Leader>s :s %<CR>
nnoremap <Leader>ev :e $MYVIMRC<CR>
nnoremap <Leader>sv :so $MYVIMRC<CR>
nnoremap <Leader>h :set hlsearch!<CR>

nnoremap <silent><Space><Space> :setlocal relativenumber!<CR>
" ref: https://qiita.com/r12tkmt/items/b89df403f587216802f1
" === [window] ===
nmap <Leader>w [window]
  " ref: https://lesguillemets.github.io/blog/2014/10/16/vim-window-controls.html
  " Openeing a window
  " <C-w>s == :split
  nnoremap [window]s <C-w>s
  " <C-w>v == :vsplit
  nnoremap [window]v <C-w>v
  " <C-w>n == :new
  nnoremap [window]n <C-w>n
  " Closing a window
  " <C-w>q == :quit
  nnoremap [window]q <C-w>q
  " <C-w>o == :only
  nnoremap [window]o <C-w>o
  " <C-w>r .. rotate window
  " Moving cursor to other windows
  nnoremap [window]h <C-w>h
  nnoremap [window]j <C-w>j
  nnoremap [window]k <C-w>k
  nnoremap [window]l <C-w>l
  " Moving windows around
  nnoremap [window]r <C-w>r
  " <C-w>p
  nnoremap [window]p <C-w>p

nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

nmap <Leader>t [tab]
  " ref: https://spirits.appirits.com/doruby/9017/
  " Moving current tab
  nnoremap [tab]p :tabprevious<CR>
  nnoremap [tab]<Left> :tabprevious<CR>
  nnoremap [tab]n :tabnext<CR>
  nnoremap [tab]<Right> :tabnext<CR>
  nnoremap [tab]c :tabclose<CR>

" ===================================
"   IVIM - ISETEKBD
" ===================================
if has('ivim')
  isetekbd clear
  
  isetekbd append {
    \ 'buttons': [
      \ {
        \ 'keys': [
          \ { 'title': '⎋', 'type': 'special', 'contents': 'esc' },
          \ { 'title': '⌃', 'type': 'modifier', 'contents': 'control' },
        \ ],
        \ 'locations': [0, 1]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': '⇥', 'type': 'special', 'contents': 'tab' },
          \ { 'title': '⌥', 'type': 'modifier', 'contents': 'alt' }
        \ ]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': '⌃', 'type': 'modifier', 'contents': 'control' }
        \ ]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': '⌥', 'type': 'modifier', 'contents': 'alt' }
        \ ]
      \ },
      \ {
        \ 'keys': [
        \ ]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': '←', 'type': 'special', 'contents': 'left' },
          \ { 'title': 'home', 'type': 'command', 'contents': 'eval feedkeys("\<Home>")' }
        \ ]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': '↓', 'type': 'special', 'contents': 'down' },
          \ { 'title': 'PgDn', 'type': 'command', 'contents': 'eval feedkeys("\<PageDown>")' }
        \ ]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': '↑', 'type': 'special', 'contents': 'up' },
          \ { 'title': 'PgUp', 'type': 'command', 'contents': 'eval feedkeys("\<PageUp>")' }
        \ ]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': '→', 'type': 'special', 'contents': 'right' },
          \ { 'title': 'end', 'type': 'command', 'contents': 'eval feedkeys("\<End>")' }
        \ ]
      \ },
      \ {
        \ 'keys': [
          \ { 'title': 'del', 'type': 'command', 'contents': 'eval feedkeys("\<Del>")' }
        \ ]
      \ }
    \ ]
  \ }
endif

filetype on
filetype plugin on
filetype indent on

execute 'set guifont=' . g:custom_guifont
execute 'set background=' . g:custom_background
execute 'colorscheme ' . g:custom_colorscheme
