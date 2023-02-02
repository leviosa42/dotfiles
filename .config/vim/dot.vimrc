"
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|
"
"" Vi Improved
set nocompatible
" Before --- {{{
syntax off
filetype plugin indent off
" }}}
" XDG Base Directory --- {{{
" - Set enviroment variables --- {{{
if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif
if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = $HOME . '/.cache'
endif
if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = $HOME . '/.local/share'
endif
if empty($XDG_STATE_HOME)
  let $XDG_STATE_HOME = $HOME . '/.local/state'
endif
" - }}}
" - Path Variable --- {{{
let s:runtime_path = $XDG_DATA_HOME . '/vim'
let s:swap_path = $XDG_CACHE_HOME . '/vim/swap'
let s:undo_path = $XDG_CACHE_HOME . '/vim/undo'
let s:viminfo_path = $XDG_STATE_HOME . '/vim/viminfo'
" - }}}
" - Util Function --- {{{
function s:__mkdirp(path) abort
  if !isdirectory(a:path)
    call mkdir(a:path, 'p')
  endif
endfunction
" }}}
" - Make directories --- {{{
if !has('nvim')
  call s:__mkdirp(s:runtime_path)
  call s:__mkdirp(s:swap_path)
  call s:__mkdirp(s:undo_path)
  call s:__mkdirp(s:viminfo_path)
endif
" - }}}
" - Set options --- {{{
if !has('nvim')
  " backup
  set backupdir=$XDG_CACHE_HOME/vim/backup
  " swap
  set directory=$XDG_CACHE_HOME/vim/swap
  " undo
  set undofile
  set undodir=$XDG_CACHE_HOME/vim/undo
  " viminfo
  set viminfo+=n$STATE_HOME/vim/viminfo
  " runtimepath
  set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_DATA_HOME/vim,$VIM,$VIMRUNTIME
else
  " backup
  set backupdir=$XDG_CACHE_HOME/nvim/backup
  " swap
  set directory=$XDG_CACHE_HOME/nvim/swap
  " undo
  set undofile
  set undodir=$XDG_CACHE_HOME/nvim/undo
  " shada(viminfo)
  set shadafile=$XDG_STATE_HOME/nvim/shada
  " runtimepath
  set runtimepath=$XDG_CONFIG_HOME/nvim,$XDG_DATA_HOME/nvim,$VIM,$VIMRUNTIME
" packpath
endif
let &packpath = &runtimepath
" - }}}
" }}}
" Global Variables --- {{{
" - ColorScheme --- {{{
let g:conf_background = 'dark'
let g:conf_colorscheme_default = 'pablo'
let g:conf_colorscheme = 'tokyonight'
" - - gruvbox ---  {{{
"let g:custom_colorscheme = 'gruvbox'
" - - }}}
" - - tokyonight --- {{{
"let g:custom_colorscheme = 'tokyonight'
  let g:tokyonight_style = 'night'
  let g:tokyonight_enable_italic = 0
  let g:tokyonight_disable_italic_comment = 1
" - - }}}
" - - everforest --- {{{
"let g:custom_colorscheme = 'everforest'
  let g:everforest_background = 'hard'
  let g:everforest_better_performance = 1
" - - }}}
" - - solarized --- {{{
let g:solarized_termcolors = 16
"let g:solarized_termtrans = 1
let g:solarized_visibility = 'high'
let g:solarized_contrast = 'high'
" - - }}}
" - }}}
" - Font --- {{{
let g:conf_guifont = 'HackGenNerd\ Console:h13'
" - }}}
" - Plugin Manager --- {{{
let g:conf_enable_pluginmanager = 1
if executable('git')
  let g:jetpack_download_method = 'git'
elseif executable('curl')
  let g:jetpack_download_method = 'curl'
elseif executable('wget')
  let g:jetpack_download_method = 'wget'
endif
"  }}}
let g:conf_use_customline = 0
let g:conf_use_expandtab_default = 1
let g:mapleader = "\<Space>"
" }}}
" General --- {{{
" - Encoding --- {{{
set fileformat=unix
set fileformats=unix,dos
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,cp932,euc-jp
" - }}}
" - Clipboard --- {{{
set clipboard+=unnamed
set clipboard+=unnamedplus
" - }}}
" - Control --- {{{
set mouse=a
set whichwrap=b,s,<,>,[,]
set timeout
set timeoutlen=2000
set ttimeoutlen=-1
" - }}}
" - Help --- {{{
set helpheight&vim
set helplang=ja
" - }}}
" - FileType --- {{{
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
" - }}}
" }}}
" Editing --- {{{
" - Searching --- {{{
set incsearch
set ignorecase
set smartcase
"set hlsearch
"- }}}
" - Command-Line --- {{{
set wildmenu
set wildmode=longest:list,full
" - }}}
" - Modifying --- {{{
set backspace=indent,eol,start
" - }}}
" - Indent --- {{{
if g:conf_use_expandtab_default
  set expandtab
else
  set noexpandtab
endif
set sts=-1 sw=0
set autoindent
set smartindent
" - FileType Indent --- {{{
" ref: https://qiita.com/ysn/items/f4fc8f245ba50d5fb8b0
augroup filetype_indent_settings
  au FileType vim    setl et   ts=2 sts=-1 sw=0
  au FileType c      setl noet ts=4 sts=-1 sw=0 cindent
  au FileType js     setl noet ts=4 sts=-1 sw=0
  au FileType python setl et   ts=4 sts=-1 sw=0
  au FileType sh     setl et   ts=2 sts=-1 sw=0
augroup END
" - }}}
" }}}
" }}}
" Appearance --- {{{
set number
set ruler
set cursorline
set showcmd
set showmatch
set showcmd
set noshowmode
if has('termguicolors')
  set termguicolors
endif
set ambiwidth=double " Especially for NF's icons
" - Listchars --- {{{
set list
set listchars=   " init
set listchars+=tab:>\ 
set listchars+=trail:~
set listchars+=nbsp:%
"set listchars+=eol:$
set listchars+=extends:»
set listchars+=precedes:«
"set listchars+=space:·
" - }}}
" - StatusLine --- {{{
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

if g:conf_use_customline
  augroup customline
    autocmd!
    autocmd ColorScheme * call g:customline.Init()
    autocmd WinEnter,BufEnter * setl stl=%!g:customline.CreateStatusLine(1)
    autocmd WinLeave,BufLeave * setl stl=%!g:customline.CreateStatusLine(0)
  augroup END
  set statusline=%!g:customline.CreateStatusLine(1)
endif
" - }}}
" - FoldText --- {{{
function! MyFoldText() abort
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 5
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . '..' . foldedlinecount  . ' '
endfunction " }}}
set foldtext=MyFoldText()
" - }}}
" GUI --- {{{
" - GUI Options --- {{{
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=e
" - }}}
" }}}
" Key Mappings --- {{{
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap <silent><Space><Space> :setlocal relativenumber!<CR>
nnoremap <Leader>h :set hlsearch!<CR>
"inoremap { {}<Left>
"inoremap [ []<Left>
"inoremap ( ()<Left>
"inoremap ' ''<Left>
"inoremap " ""<Left>
" nnoremap <Tab> :tabnext<CR>
" nnoremap <S-Tab> :tabprevious<CR>
" - [window] --- {{{
" ref: https://qiita.com/r12tkmt/items/b89df403f587216802f1
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
" - }}}
" - [tab] --- {{{
nmap <Leader>t [tab]
  " ref: https://spirits.appirits.com/doruby/9017/
  " Moving current tab
  nnoremap [tab]p :tabprevious<CR>
  nnoremap [tab]<Left> :tabprevious<CR>
  nnoremap [tab]h :tabprevious<CR>
  nnoremap [tab]n :tabnext<CR>
  nnoremap [tab]<Right> :tabnext<CR>
  nnoremap [tab]l :tabnext<CR>
  nnoremap [tab]c :tabclose<CR>
" - }}}
" - [vimrc] --- {{{
nmap <Leader>v [vimrc]
  nnoremap [vimrc]e :e $MYVIMRC<CR>
  nnoremap [vimrc]<S-e> :e! $MYVIMRC<CR>
  nnoremap [vimrc]t :tabnew $MYVIMRC<CR>
  nnoremap [vimrc]s :so $MYVIMRC<CR>
" - }}}
" }}}
" Plugins --- {{{
" - Processes Function --- {{{
function g:__jetpack_setup(pmpath) abort
  " bootstrap
  let s:jetpackfile = a:pmpath . '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
  let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
  if !filereadable(s:jetpackfile) && executable('curl')
    call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
  endif
  "runtime */jetack.vim
  packadd vim-jetpack
endfunction
" - }}}
" - Add Plugins Function --- {{{
function g:__jetpack_add_plugins(pmpath) abort
  call jetpack#begin(a:pmpath)
  call jetpack#add('tani/vim-jetpack', {'opt': 1}) " bootstrap
  " - - General --- {{{
  call jetpack#add('vim-jp/vimdoc-ja')
  call jetpack#add('lambdalisue/fern.vim')
  call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim', {'depends': 'lambdalisue/nerdfont.vim'})
  call jetpack#add('lambdalisue/nerdfont.vim')
  call jetpack#add('yuki-yano/fern-preview.vim', {'depends': 'lambdalisue/fern.vim'})
  " - - }}}
  " - - Editings --- {{{
  call jetpack#add('jiangmiao/auto-pairs')
  call jetpack#add('markonm/traces.vim')
  " - }}}
  " - - Appearance --- {{{
  call jetpack#add('itchyny/lightline.vim')
  " - - }}}
  " - - ColorSchemes --- {{{
  call jetpack#add('catppuccin/vim', {'as': 'catppuccin'})
  call jetpack#add('danilo-augusto/vim-afterglow')
  call jetpack#add('arcticicestudio/nord-vim')
  "call jetpack#add('altercation/vim-colors-solarized')
  " - - }}}
  call jetpack#end()
endfunction
" - }}}
" - Main Process --- {{{
if g:conf_enable_pluginmanager
  let g:pmpath = $XDG_DATA_HOME . '/vim'
  if !has('nvim') " idk why this script runs correctly on nvim
    call g:__jetpack_setup(g:pmpath)
    call g:__jetpack_add_plugins(g:pmpath)
  endif
endif
" - }}}
" - Plugin Settings --- {{{
" - - [lambdalisue/fern.vim] --- {{{
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden = 1
function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
endfunction
augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
nnoremap <silent> <Leader>E :<C-u>Fern . -reveal=%<CR>
nnoremap <silent> <Leader>e :<C-u>Fern . -reveal=% -drawer -toggle<CR>
" preview
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END
" }}}
" - - [itchyny/lightline.vim] --- {{{
" ref: https://qiita.com/hoto17296/items/ccbd6b413e67a653f2d
let g:lightline = {
  \ 'colorscheme': 'tokyonight',
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \ }
set noshowmode
augroup lightline_vim
  autocmd VimEnter * call lightline#update()
augroup END
" - - }}}
" - }}}
" }}}
" After --- {{{
syntax enable
execute 'set background=' . g:conf_background
try
  execute 'colorscheme ' . g:conf_colorscheme
catch
  execute 'colorscheme ' . g:conf_colorscheme_default
endtry
execute 'set guifont=' . g:conf_guifont
filetype plugin indent on
" }}}
" vim: set ft=vim ts=2 sts=-1 sw=0 expandtab autoindent smartindent foldmethod=marker:

