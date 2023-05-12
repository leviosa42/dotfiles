"       _               "
"  __ _(_)_ __  _ _ __  "
"  \ V / | '  \| '_/ _| "
" (_)_/|_|_|_|_|_| \__| "
"                       "
" * Pre Init: {{{
" [:h encoding(enc)] Sets the character encoding used inside Vim.
set encoding=utf-8
" [:h scriptencoding(scripte)] Specify the character encoding used in the script.
scriptencoding utf-8

if &compatible
  set nocompatible
endif

syntax off
filetype plugin indent off

let $MYVIMRC = expand('<sfile>')

if $SHELL =~? 'nyagos'
  set shellcmdflag=-c
endif

let s:vimrc = {}

function! s:vimrc.GetHome() " {{{
  if $TERM_PRORAM ==# 'a-Shell' " a-Shell
    return expand('~/Documents')
  elseif exists('$HOME') || has('ivim') " iVim
    return $HOME
  elseif exists('$USERPROFILE') " windows
    return $USERPROFILE
  else
    return expand('<sfile>:p:h')
  endif
endfunction " }}}

let g:home = s:vimrc.GetHome()
" * }}}
" * XDG Based Directory: {{{
" $XDG_CONFIG_HOME/ <- $HOME/.config
" +- vim/
"    +- dot.vimrc
"
" $XDG_CACHE_HOME/ <- $HOME/.cache
" +- vim/
"    +- swap/
"
" $XDG_DATA_HOME/ <- $HOME/.loca/share
" +- vim/
"    +- backup/
"    +- pack/
"       +- jetpack/
"
" $XDG_STATE_HOME/ <- $HOME/.local/state
" +- vim/
"    +- undo/
"    +- viminfo.txt
if !exists('$XDG_CONFIG_HOME')
  let $XDG_CONFIG_HOME = g:home .. '/.config'
endif
if !exists('$XDG_CACHE_HOME')
  let $XDG_CACHE_HOME = g:home .. '/.cache'
endif
if !exists('$XDG_DATA_HOME')
  let $XDG_DATA_HOME = g:home .. '/.local/share'
endif
if !exists('$XDG_STATE_HOME')
  let $XDG_STATE_HOME = g:home .. '/.local/state'
endif
call mkdir($XDG_CONFIG_HOME, 'p')
call mkdir($XDG_CACHE_HOME, 'p')
call mkdir($XDG_DATA_HOME, 'p')
call mkdir($XDG_STATE_HOME, 'p')

set directory=$XDG_CACHE_HOME/vim/swap
set swapfile
set backupdir=$XDG_DATA_HOME/vim/backup
set undodir=$XDG_STATE_HOME/vim/undo
set undofile
set undolevels=1000
set viminfo+=n$XDG_STATE_HOME/vim/viminfo

call mkdir(&directory, 'p')
call mkdir(&backupdir, 'p')
call mkdir(&undodir, 'p')

set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_DATA_HOME/vim,$VIM,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
let &packpath = &runtimepath

let $MYVIMRC = expand('<sfile>')
" * }}}
" * Plugin: {{{
" * * Default Plugin: {{{
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_sizestyle = 'H'
let g:netrw_timefmt = '%Y-%m-%dT%H:%M:%S'
let g:netrw_winsize = 25
let g:vimrc_explorer = 'netrw' " as default
" * * }}}
" * * Custom Plugin: {{{
" * * * Automatic installation on startup: {{{
let s:jetpackfile = expand('$XDG_DATA_HOME/vim') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif
" * * * }}}
if executable('git') && 1
" * * * Add plugins: {{{
packadd vim-jetpack
call jetpack#begin(expand('$XDG_DATA_HOME/vim'))
  call jetpack#add('tani/vim-jetpack', {'opt': 1}) "bootstrap
  call jetpack#add('vim-jp/vimdoc-ja') " help@ja
  call jetpack#add('sheerun/vim-polyglot') " lang packs
  call jetpack#add('pprovost/vim-ps1') " lang for ps1
  call jetpack#add('lambdalisue/fern.vim') " file explorer
    " lambdalisue/fern.vim {{{
    let g:vimrc_explorer = 'fern'
    let g:fern#default_hidden = 1
    function! s:fern_settings() abort
      " https://github.com/lambdalisue/fern.vim/issues/270#issuecomment-740257133
      setlocal nornu nonu nolbr signcolumn=no foldcolumn=0

      " fern-preview.vim 's mapping
      nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
      nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
      nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
      nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
      " smart_perview function
      nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
      nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
      " my custom mapping
      nmap <silent> <buffer> H <Plug>(fern-action-leave)
      nmap <silent> <buffer> L <Plug>(fern-action-open-or-expand)
    endfunction

    augroup fern-settings
      autocmd!
      autocmd FileType fern call s:fern_settings()
    augroup END
    " }}}
    call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
      " lambdalisue/fern-renderer-nerdfont.vim {{{
      let g:fern#renderer = "nerdfont"
      " }}}
      call jetpack#add('lambdalisue/nerdfont.vim')
    call jetpack#add('yuki-yano/fern-preview.vim')
  call jetpack#add('machakann/vim-sandwich')
  call jetpack#add('markonm/traces.vim')
  call jetpack#add('machakann/vim-highlightedyank')
  call jetpack#add('tomasr/molokai') " colorscheme
  call jetpack#add('AlessandroYorba/Sierra') " colorscheme
    let g:sierra_Mignight = 1
  " call jetpack#add('cormacrelfm/vim-colors-github') " colorscheme
  call jetpack#add('leviosa42/vim-github-theme') " colorscheme
  call jetpack#add('leviosa42/kanagawa-mini.vim') " colorscheme
  call jetpack#add('sonph/onehalf', {'rtp': 'vim'}) " colorscheme
  call jetpack#add('tpope/vim-commentary')
  " call jetpack#add('itchyny/lightline.vim')
call jetpack#end()

augroup vim-jetpack-mypatch
  autocmd VimEnter * setl nomodified
augroup END
" * * * }}}
endif
" * * }}}
" * * Local Plugin: {{{
" set rtp+=~/vim-dev/stoneline.vim
set rtp+=~/vim-dev/github-theme-mini.vim
set rtp+=~/vim-dev/vim-github-theme
" let g:stoneline.feat_mode_hl_termansicolors = 1
" * * }}}
" * }}}
" * General: {{{
set noshellslash
set novisualbell
set modeline
" * * Formats: {{{
set fileformat=unix
set fileformats=unix,dos
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
  au FileType vim    setl et   ts=2 sts=-1 sw=0 | let g:vim_indent_cont = &sw
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
set foldcolumn=1
set showcmd
set showmatch
if has('termguicolors') && !has('gui_running') && 1
  set termguicolors
endif
set ambiwidth=single
" * * GUI Options --- {{{
let &guifont = 'PlemolJP Console NF:h13'
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=e
" * * }}}
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
set fillchars+=vert:│ " U+2502
set fillchars+=foldclose:>
set fillchars+=foldopen:┌ " U+250C
set fillchars+=foldsep:│ " U+2502
set fillchars+=eob:\ 
" * * }}}
" * * StatusLine: {{{
set laststatus=2
set ruler
set showmode
" baased on https://github.com/KaraMCC/vim-streamline/tree/master/plugin
" license: https://github.com/KaraMCC/vim-streamline/blob/master/LICENSE
" function! GetBufSize() abort
" let l:bufbytes = wordcount().bytes
" echo l:bufbytes
" endfunction
function! g:PureStatusLine() abort " {{{
  " * constants {{{
  let MODE_TITLES = {
    \ 'n':      ['N', 'NORMAL'],
    \ 'v':      ['V', 'VISUAL'],
    \ 'V':      ['VL', 'V-LINE'],
    \ "\<C-v>": ['VB', 'V-BLOCK'],
    \ 's':      ['S', 'SELECT'],
    \ 'S':      ['SL', 'S-LINE'],
    \ "\<C-s>": ['SB', 'S-BLOCK'],
    \ 'i':      ['I', 'INSERT'],
    \ 'R':      ['R', 'REPLACE'],
    \ 'c':      ['C', 'COMMAND'],
    \ 't':      ['T', 'TERMINAL']
    \ }
  " * }}}
  " * main {{{
  let m = mode(0)
  let is_wide = winwidth(0) > 70
  let sep = ' ▏'

  let s = ''
  let s .= ' ' .. MODE_TITLES[m][is_wide]
  let s .= sep
  let s .= (m ==# 't') ? '<terminal>' : '%f'
  let s .= ' '
  let s .= '%y'
  let s .= '%m'
  let s .= '%r'
  let s .= '%w'
  let s .= '%='
  let s .= is_wide ? (&fenc?&fenc:&enc) : ''
  let s .= is_wide ? ' ' : ''
  let s .= is_wide ? &ff : ''
  let s .= sep
  let s .= is_wide ? '%l:%c ' : ''
  let s .= '%p%% '

  return s
  " * }}}
endfunction " }}}
set stl=%{%g:PureStatusLine()%}

" rich statusline {{{
let g:statusline_config = {}
let g:statusline_config.mode_title = {
  \ 'n':      ['N', 'NORMAL'],
  \ 'v':      ['V', 'VISUAL'],
  \ 'V':      ['VL', 'V-LINE'],
  \ "\<C-v>": ['VB', 'V-BLOCK'],
  \ 's':      ['S', 'SELECT'],
  \ 'S':      ['SL', 'S-LINE'],
  \ "\<C-s>": ['SB', 'S-BLOCK'],
  \ 'i':      ['I', 'INSERT'],
  \ 'R':      ['R', 'REPLACE'],
  \ 'c':      ['C', 'COMMAND'],
  \ 't':      ['T', 'TERMINAL']
  \ }
let g:statusline_config.mode_highlight = {
  \ 'normal':   [[0, 12-8], 'Constant'],
  \ 'insert':   [[0, 10-8], 'Identifier'],
  \ 'visual':   [[0, 13-8], 'Statement'],
  \ 'select':   [[0, 9-8], 'PreProc'],
  \ 'replace':  [[0, 11-8], 'Type'],
  \ 'command':  [[0, 12-8], 'Constant'],
  \ 'terminal': [[0, 14-8], 'Special'],
  \ 'inactive': [[0, 8], 'Comment'],
  \ 'ignore':   [[15, 0], 'Ignore']
  \ }
let g:statusline_config.UseMinimalChecker = { -> winwidth(0) < 70 }

function! g:DefineModeHighlight(use_termansicolor) abort " {{{
  let mhl = g:statusline_config.mode_highlight
  for [k, v] in items(mhl)
    if a:use_termansicolor
      execute 'highlight StatusLine_' .. k
        \ 'guifg=' .. g:terminal_ansi_colors[v[0][0]]
        \ 'guibg=' .. g:terminal_ansi_colors[v[0][1]]
    else
      execute 'highlight link' 'Statusline_' .. k v[1]
    endif
  endfor
endfunction " }}}

function! g:GetModeType(mode) abort " {{{
  let m = a:mode[0]
  if m ==# 'n'
    return 'normal'
  elseif m ==# 'v' || m ==# 'V' || m ==# "\<C-v>"
    return 'visual'
  elseif m ==# 's' || m ==# 'S' || m ==# "\<C-s>"
    return 'select'
  elseif m ==# 'i'
    return 'insert'
  elseif m ==# 'R'
    return 'replace'
  elseif m ==# 'c'
    return 'command'
  elseif m ==# 't'
    return 'terminal'
  else
    return 'ignore'
  endif
endfunction " }}}

function! g:GetModeHighlightName(mode) abort " {{{
  let type = g:GetModeType(a:mode)
  return 'StatusLine_' .. type
endfunction " }}}

function! g:CreateActiveStatusLine() abort " {{{
  let use_minimal = g:statusline_config.UseMinimalChecker()
  let s = ''
  let s .= '%#' .. g:GetModeHighlightName(mode()) .. '#'
  let s .= ' %{g:statusline_config.mode_title[mode(0)][' .. !use_minimal .. ']} '
  let s .= &modified ? '%#DiffAdd#' : '%#CursorLineNr#'
  let s .= mode(0) ==# 't' ? ' <terminal>' : ' %f'
  let s .= ' '
  let s .= '%y'              " Show filetype
  let s .= '%m'
  let s .= '%='
  if !use_minimal
    let s .= '%#DiffText#'
    " let s .= '▏'
    let s .= ' '
    let s .= '%{&fileencoding?&fileencoding:&encoding}'
    let s .= ' %{&fileformat} '
  endif
  " let s .= '▏'
  let s .= '%#Search#'
  let s .= ' '
  let s .= '%l:%c'              " Show line number and column
  let s .= ' '
  if !use_minimal
    let s .= '%p%% '               " Show percentage
  endif
  return s
endfunction " }}}

function! g:CreateInactiveStatusLine() abort " {{{
  let use_minimal = g:statusline_config.UseMinimalChecker()
  let s = ''
  let s .= '%#StatusLineNC#'
  let s .= ' %{g:statusline_config.mode_title[mode(0)][' .. !use_minimal .. ']} '
  let s .= mode(0) ==# 't' ? '▏<terminal>' : '▏%f'
  let s .= ' '
  let s .= '%y'              " Show filetype
  let s .= '%m'
  let s .= '%='
  if !use_minimal
    let s .= '▏'
    " let s .= ' '
    let s .= '%{&fileencoding?&fileencoding:&encoding}'
    let s .= ' %{&fileformat} '
  endif
  let s .= '▏'
  " let s .= ' '
  let s .= '%l:%c'              " Show line number and column
  let s .= ' '
  if !use_minimal
    let s .= '%p%% '               " Show percentage
  endif
  let s .= '%#VertSplit#'
  return s
endfunction " }}}

function! g:Init() abort " {{{
  call g:DefineModeHighlight(exists('g:terminal_ansi_colors') && 1)
  set statusline=%!g:CreateActiveStatusLine()
  augroup statusline
    autocmd!
    autocmd BufEnter,WinEnter * setlocal statusline=%!g:CreateActiveStatusLine()
    autocmd Bufleave,WinLeave * setlocal statusline=%!g:CreateInactiveStatusLine()
  augroup END
endfunction " }}}
" * * * }}}
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
" * * MyColorScheme: {{{
function! s:github_dark() abort " {{{
  hi Function guifg=#d2a8ff guibg=NONE guisp=NONE gui=NONE
  hi Keyword guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  " QuickFixLine
  hi vimSynType guifg=#79c0ff guibg=NONE guisp=NONE gui=NONE
  hi Exception guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  hi! link lCursor Cursor
  " SpellLocal
  " SpellCap
  hi StatusLineNC guifg=#8b949e guibg=#21262d guisp=NONE gui=NONE
  hi Comment guifg=#8b949e guibg=NONE guisp=NONE gui=NONE
  hi Question guifg=#d29922 guibg=NONE guisp=NONE gui=NONE
  hi vimOption guifg=#79c0ff guibg=NONE guisp=NONE gui=NONE
  " ModeMsg
  hi vimEnvvar guifg=#79c0ff guibg=NONE guisp=NONE gui=NONE
  " SpellBad
  hi vimGroupName guifg=#79c0ff guibg=NONE guisp=NONE gui=NONE
  " VisualNOS
  hi! link vimUserFunc Function
  hi WarningMsg guifg=#d29922 guibg=NONE guisp=NONE gui=NONE
  " PmenuSbar
  hi FoldColumn guifg=#bc8cff guibg=#231f39 guisp=NONE gui=NONE
  hi Cursor guifg=NONE guibg=#484f58 guisp=NONE gui=NONE
  hi DiffDelete guifg=NONE guibg=#301a1f guisp=NONE gui=NONE
  hi Visual guifg=NONE guibg=#2f2a1e guisp=NONE gui=NONE
  hi WildMenu guifg=NONE guibg=#1f6feb guisp=NONE gui=NONE
  hi CursorLine guifg=NONE guibg=#21262d guisp=NONE gui=NONE
  hi CursorLineNr guifg=#f0f6fc guibg=#21262d guisp=NONE gui=NONE
  hi Special guifg=#d2a8ff guibg=NONE guisp=NONE gui=NONE
  hi TabLineFill guifg=NONE guibg=#161b22 guisp=NONE gui=NONE
  hi Terminal guifg=#c9d1d9 guibg=#0d1117 guisp=NONE gui=NONE
  hi PmenuSel guifg=#58a6ff guibg=#21262d guisp=NONE gui=NONE
  " MoreMsg
  hi LineNr guifg=#8b949e guibg=#161b22 guisp=NONE gui=NONE
  hi Label guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  hi! link CursorLineSign SignColumn
  " ScrollBar
  hi Statement guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  hi! link CursorIM Cursor
  hi CursorLineFold guifg=#d2a8ff guibg=#493771 guisp=NONE gui=NONE
  " SpecialKey
  " Directory
  hi DiffAdd guifg=NONE guibg=#12261e guisp=NONE gui=NONE
  hi Identifier guifg=#f0f6fc guibg=NONE guisp=NONE gui=NONE
  hi DiffChange guifg=NONE guibg=#272115 guisp=NONE gui=NONE
  hi! link CurSearch Search
  hi ErrorMsg guifg=#f85149 guibg=NONE guisp=NONE gui=NONE
  hi TabLine guifg=#8b949e guibg=#161b22 guisp=NONE gui=NONE
  hi vimHiAttrib guifg=NONE guibg=NONE guisp=NONE gui=NONE
  hi EndOfBuffer guifg=#161b22 guibg=#161b22 guisp=NONE gui=NONE
  " PmenuThumb
  hi Type guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  hi TabLineSel guifg=#f0f6fc guibg=#484f58 guisp=NONE gui=NONE
  hi Delimiter guifg=#f0f6fc guibg=NONE guisp=NONE gui=NONE
  " Menu
  hi Repeat guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  hi DiffText guifg=NONE guibg=#13233a guisp=NONE gui=NONE
  hi String guifg=#a5d6ff guibg=NONE guisp=NONE gui=NONE
  hi VertSplit guifg=#30363d guibg=#161b22 guisp=NONE gui=NONE
  hi Error guifg=#f85149 guibg=NONE guisp=NONE gui=NONE
  hi Preproc guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  " Number
  hi Pmenu guifg=#8b949e guibg=#161b22 guisp=NONE gui=NONE
  " Conceal
  hi! link CursorColumn CursorLine
  hi Title guifg=#d2a8ff guibg=NONE guisp=NONE gui=NONE
  hi NonText guifg=#8b949e guibg=#161b22 guisp=NONE gui=NONE
  hi Constant guifg=#79c0ff guibg=NONE guisp=NONE gui=NONE
  hi SignColumn guifg=#8b949e guibg=#161b22 guisp=NONE gui=NONE
  hi StatusLine guifg=#f0f6fc guibg=#484f58 guisp=NONE gui=NONE
  " SpellRare
  hi Operator guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  hi Search guifg=NONE guibg=#533d12 guisp=NONE gui=NONE
  hi ToDo guifg=#d29922 guibg=NONE guisp=NONE gui=NONE
  hi MatchParen guifg=NONE guibg=#1f6feb guisp=NONE gui=NONE
  hi! link StatusLineTerm StatusLine
  hi Normal guifg=#f0f6fc guibg=#161b22 guisp=NONE gui=NONE
  hi Conditional guifg=#ff7b72 guibg=NONE guisp=NONE gui=NONE
  hi! link StatusLineTermNC StatusLineNC
  " Float
  hi IncSearch guifg=NONE guibg=NONE guisp=NONE gui=reverse
  hi Folded guifg=#f0f6fc guibg=#231f39 guisp=NONE gui=NONE
  " Boolean
  " Tooltip
  " ColorColumn
  " Character
endfunction " }}}
" * * }}}
" * }}}
" * Commnad: {{{
" * * :HighlightInfo {{{
" show highlight infomation under the cursor.
" ref: https://qiita.com/pasela/items/903bb9f5ac1b9b17af2c
function! <SID>get_syn_id(transparent)
    let synid = synID(line('.'), col('.'), 1)
    return a:transparent ? synIDtrans(synid) : synid
endfunction
function! <SID>get_syn_name(synid)
    return synIDattr(a:synid, 'name')
endfunction
function! <SID>get_highlight_info()
    execute "highlight " . <SID>get_syn_name(<SID>get_syn_id(0))
    execute "highlight " . <SID>get_syn_name(<SID>get_syn_id(1))
endfunction
command! HighlightInfo call <SID>get_highlight_info()
" * * }}}
" * * :DiffOrig: {{{
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" * * }}}
" * }}}
" * Key Mapping: {{{
let g:mapleader = "\<Space>"

" * * Misc: {{{
inoremap <silent>jk <Esc>

" ref: https://github.com/nvim-zh/minimal_vim
" Move the cursor based on physical lines, not the actual lines.
nnoremap <silent><expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent><expr> k (v:count == 0 ? 'gk' : 'k')

" nnoremap H ^
" nnoremap L $
nnoremap <silent><expr> J (v:count == 0 ? '3gj' : '3j')
nnoremap <silent><expr> K (v:count == 0 ? '3gk' : '3k')

" u <-> U = Undo <-> Redo
nnoremap U <C-r>
nnoremap <C-r> U

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nnoremap <silent> <Space><Space> :<C-u>setl relativenumber!<CR>:<C-u>setl relativenumber?<CR>

" nnoremap <Leader>h :<C-u>nohlsearch<CR>:echo v:hlsearch ? 'hlsearch' : 'nohlsearch'<CR>
nnoremap <Leader>h :<C-u>setl hlsearch!<CR>:setl hlsearch?<CR>

nnoremap x "_x

inoremap <S-Tab> <Tab>

nnoremap <silent> <S-Up> "zdd<Up>"zP
nnoremap <silent> <S-Down> "zdd"zp
vnoremap <silent> <S-Up> "zx<Up>"zP`[V`]
vnoremap <silent> <S-Down> "zx"zp`[V`]

" nmap >> >>>
" nmap << <<<
        vmap >> >>gv>
vmap << <<gv

if has('gui_running')
  let g:vimrc_guisize = 1
  nnoremap <silent> <expr> <F11> g:vimrc_winsize ? ":simalt ~x\<CR>" : ":simalt ~r\<CR>"
endif
" * * }}}
" * * [explorer]: {{{
nmap <leader>e [explorer]
nnoremap [explorer] <Nop>
if g:vimrc_explorer ==# 'netrw'
" * * * (netrw): {{{
" Toggle Vexplore with Ctrl-E
" https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
function! ToggleVExplorer() " {{{
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
endfunction " }}}

nnoremap <silent> [explorer]e :<C-u>call ToggleVExplorer()<CR>
" * * * }}}
elseif g:vimrc_explorer ==# 'fern'
" * * * (fern): {{{
nnoremap <silent> [explorer]e :<C-u>Fern . -drawer -toggle -keep<CR>
nnoremap <silent> [explorer]d :<C-u>Fern %:h -drawer -toggle -keep<CR>
" * * * }}}
endif
" * * }}}
" * * [buffer]: {{{
nmap <Leader>b [buffer]
nnoremap [buffer] <Nop>
nnoremap [buffer]n :<C-u>new<CR>
nnoremap [buffer]k :<C-u>bprev<CR>
nnoremap [buffer]j :<C-u>bnext<CR>
nnoremap [buffer]l :<C-u>ls<CR>
nnoremap [buffer]L :<C-u>ls!<CR>
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

nnoremap [terminal]x :<C-u>terminal ++curwin<CR>

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
" * * command-line: {{{
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
" * * }}}
" * }}}
" * iVim: {{{
if has('ivim')
  let &guifont = 'PlemolJP Console NF:h25'
  " https://github.com/terrychou/iVim/wiki/External-Command:-curl
  let $SSL_CERT_FILE = expand('~/cacert.pem')
  if filereadable($SSL_CERT_FILE)
    call system(printf('cd ~ && curl --remote-name --time-cond %s https://curl.haxx.se/ca/cacert.pem', $SSL_CERT_FILE))
  else
    call system(printf('curl -kOL https://curl.haxx.se/ca/cacert.pem -o %s', $SSL_CERT_FILE))
  endif
  silent !alias ls='ls -F'
  silent !alias ll='ls -l'
  silent !alias la='ls -a'
  silent !alias al='ls -al'
  silent !alias q=exit
  silent !alias ':q'=exit
endif

" * }}}
" * Post Init: {{{
syntax enable
set background=dark
try
  " call g:SetMyColorScheme()
  " colorscheme kanagawa-mini
  let g:github = {
    \ 'theme': 'dark',
    \ 'enable_termcolors': 1
    \ }
  colorscheme github
  " colorscheme github-mini
  " call s:github_dark()
catch
  colorscheme desert
endtry

" call g:Init()
filetype plugin indent on
" * }}}
" vim: set ft=vim ts=2 sts=-1 sw=0 et fdm=marker fmr={{{,}}} fdc=5 fdls=0 cms="\ %s:

