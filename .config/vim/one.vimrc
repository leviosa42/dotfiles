"                         _                     "
"   ___  _ __   _____   _(_)_ __ ___  _ __ ___  "
"  / _ \| '_ \ / _ \ \ / / | '_ ` _ \| '__/ __| "
" | (_) | | | |  __/\ V /| | | | | | | | | (__  "
"  \___/|_| |_|\___(_)_/ |_|_| |_| |_|_|  \___| "
"                                               "
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

let g:vimrc ={}
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

let g:vimrc.home = s:vimrc.GetHome()
" set rtp+=~/vim-dev/vim-xvi,~/vim-dev/kanagawa-mini.vim
set rtp+=~/vim-dev/stoneline.vim
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
" * * ColorScheme: {{{
" Name:        Kanagawa-mini
" Description: A minimal color scheme ported from rebelot's kanagawa.nvim for Vim.
"              See also: https://github.com/rebelot/kanagawa.nvim
" Author:      leviosa42
" WebSite:     https://github.com/leviosa42/kanagawa-mini.vim
" License:     MIT license

if !exists('s:kanagawa_mini')
  let s:kanagawa_mini = {}
endif

function! s:kanagawa_mini.get_config(userconfig) abort " {{{
  let l:config = {}
  let l:config.undercurl = get(a:userconfig, 'undercurl', v:true)
  let l:config.commentStyle = get(a:userconfig, 'commentStyle', 'italic')
  let l:config.functionStyle = get(a:userconfig, 'functionStyle', 'NONE')
  let l:config.keywordStyle = get(a:userconfig, 'keywordStyle', 'italic')
  let l:config.statementStyle = get(a:userconfig, 'statementStyle', 'bold')
  let l:config.typeStyle = get(a:userconfig, 'typeStyle', 'NONE')
  " NOTE: The 'variablebuiltinStyle' option was originally for nvim-treesitter's '@variable.built-in'
  "       and is therefore not supported.
  let l:config.specialReturn = get(a:userconfig, 'specialReturn', v:true)
  let l:config.specialExeption = get(a:userconfig, 'specialExeption', v:true)
  let l:config.transparent = get(a:userconfig, 'transparent', v:false)
  " NOTE: The 'dimInactive' options was originally for nvim's 'NormalNC'
  "       highlight-group and is therefore not support.
  "       However, since WinSeparator(VertSplit) uses this option,
  "       the option itself is not removed for future use.
  let l:config.dimInactive = get(a:userconfig, 'dimInactive', v:false)
  " NOTE: It is unsupported because it is used to adjust the highlighting of the
  "       window separator with laststatus=3.
  let l:config.terminalColors = get(a:userconfig, 'terminalColors', v:true)
  " NOTE: The 'colors' option is not yet implemented.
  "let l:config.colors = get(a:userconfig, 'colors', {})
  " NOTE: The 'overrides' option is not yet implemented.
  "let l:config.overrides = get(a:userconfig, 'overrides', {})
  let l:config.theme = get(a:userconfig, 'theme', 'default')
  return l:config
endfunction " }}}

function! s:kanagawa_mini.get_palette(theme) abort " {{{
  let l:palettes  = {
        \ 'default': {
        \ 'sumiInk0'      : '#16161D',
        \ 'sumiInk1b'     : '#181820',
        \ 'sumiInk1c'     : '#1a1a22',
        \ 'sumiInk1'      : '#1F1F28',
        \ 'sumiInk2'      : '#2A2A37',
        \ 'sumiInk3'      : '#363646',
        \ 'sumiInk4'      : '#54546D',
        \ 'waveBlue1'     : '#223249',
        \ 'waveBlue2'     : '#2D4F67',
        \ 'winterGreen'   : '#2B3328',
        \ 'winterYellow'  : '#49443C',
        \ 'winterRed'     : '#43242B',
        \ 'winterBlue'    : '#252535',
        \ 'autumnGreen'   : '#76946A',
        \ 'autumnRed'     : '#C34043',
        \ 'autumnYellow'  : '#DCA561',
        \ 'samuraiRed'    : '#E82424',
        \ 'roninYellow'   : '#FF9E3B',
        \ 'waveAqua1'     : '#6A9589',
        \ 'dragonBlue'    : '#658594',
        \ 'oldWhite'      : '#C8C093',
        \ 'fujiWhite'     : '#DCD7BA',
        \ 'fujiGray'      : '#727169',
        \ 'springViolet1' : '#938AA9',
        \ 'oniViolet'     : '#957FB8',
        \ 'crystalBlue'   : '#7E9CD8',
        \ 'springViolet2' : '#9CABCA',
        \ 'springBlue'    : '#7FB4CA',
        \ 'lightBlue'     : '#A3D4D5',
        \ 'waveAqua2'     : '#7AA89F',
        \ 'springGreen'   : '#98BB6C',
        \ 'boatYellow1'   : '#938056',
        \ 'boatYellow2'   : '#C0A36E',
        \ 'carpYellow'    : '#E6C384',
        \ 'sakuraPink'    : '#D27E99',
        \ 'waveRed'       : '#E46876',
        \ 'peachRed'      : '#FF5D62',
        \ 'surimiOrange'  : '#FFA066',
        \ 'katanaGray'    : '#717C7C'
        \ }
        \ }
  return l:palettes[a:theme]
endfunction " }}}

function! s:kanagawa_mini.set_terminal_ansi_colors(palette) abort " {{{
  let g:terminal_ansi_colors = [
        \ '#090618',
        \ a:palette.autumnRed,
        \ a:palette.autumnGreen,
        \ a:palette.boatYellow2,
        \ a:palette.crystalBlue,
        \ a:palette.oniViolet,
        \ a:palette.waveAqua1,
        \ a:palette.oldWhite,
        \ a:palette.fujiGray,
        \ a:palette.samuraiRed,
        \ a:palette.springGreen,
        \ a:palette.carpYellow,
        \ a:palette.springBlue,
        \ a:palette.springViolet1,
        \ a:palette.waveAqua2,
        \ a:palette.fujiWhite,
        \ ]
  return
endfunction " }}}

function! s:kanagawa_mini.get_colors(palette) abort " {{{
  let l:colors = {
        \ 'bg' : a:palette.sumiInk1,
        \ 'bg_dim' : a:palette.sumiInk1b,
        \ 'bg_dark' : a:palette.sumiInk0,
        \ 'bg_light0' : a:palette.sumiInk2,
        \ 'bg_light1' : a:palette.sumiInk3,
        \ 'bg_light2' : a:palette.sumiInk4,
        \ 'bg_light3' : a:palette.springViolet1,
        \ 'bg_menu' : a:palette.waveBlue1,
        \ 'bg_menu_sel' : a:palette.waveBlue2,
        \ 'bg_status' : a:palette.sumiInk0,
        \ 'bg_visual' : a:palette.waveBlue1,
        \ 'bg_search' : a:palette.waveBlue2,
        \ 'fg_border' : a:palette.sumiInk4,
        \ 'fg_dark' : a:palette.oldWhite,
        \ 'fg_reverse' : a:palette.waveBlue1,
        \ 'fg_comment' : a:palette.fujiGray,
        \ 'fg' : a:palette.fujiWhite,
        \ 'fg_menu' : a:palette.fujiWhite,
        \ 'co' : a:palette.surimiOrange,
        \ 'st' : a:palette.springGreen,
        \ 'nu' : a:palette.sakuraPink,
        \ 'id' : a:palette.carpYellow,
        \ 'fn' : a:palette.crystalBlue,
        \ 'sm' : a:palette.oniViolet,
        \ 'kw' : a:palette.oniViolet,
        \ 'op' : a:palette.boatYellow2,
        \ 'pp' : a:palette.surimiOrange,
        \ 'ty' : a:palette.waveAqua2,
        \ 'sp' : a:palette.springBlue,
        \ 'sp2' : a:palette.waveRed,
        \ 'sp3' : a:palette.peachRed,
        \ 'br' : a:palette.springViolet2,
        \ 're' : a:palette.boatYellow2,
        \ 'dep' : a:palette.katanaGray,
        \ 'diag' : {
        \ 'error' : a:palette.samuraiRed,
        \ 'warning' : a:palette.roninYellow,
        \ 'info' : a:palette.dragonBlue,
        \ 'hint' : a:palette.waveAqua1,
        \ },
        \ 'diff' : {
        \ 'add' : a:palette.winterGreen,
        \ 'delete' : a:palette.winterRed,
        \ 'change' : a:palette.winterBlue,
        \ 'text' : a:palette.winterYellow,
        \ },
        \ 'git' : {
        \ 'added' : a:palette.autumnGreen,
        \ 'removed' : a:palette.autumnRed,
        \ 'changed' : a:palette.autumnYellow,
        \ },
        \ }
  return l:colors
endfunction " }}}

function! s:kanagawa_mini.h(group, style) abort " {{{
  if empty(a:style)
    return
  endif
  if has_key(a:style, 'link')
    execute 'hi!' 'link' a:group a:style.link
    return
  endif
  execute 'hi' a:group
        \ 'guibg=' . (has_key(a:style, 'bg')  ? a:style.bg  : 'NONE')
        \ 'guifg=' . (has_key(a:style, 'fg')  ? a:style.fg  : 'NONE')
        \ 'guisp=' . (has_key(a:style, 'sp')  ? a:style.sp  : 'NONE')
        \ 'gui='   . (has_key(a:style, 'gui')
        \ ? a:style.gui == 'undercurl'
        \ ? self.config.undercurl ? 'undercurl' : 'NONE'
        \ : a:style.gui
        \ : 'NONE')
endfunction " }}}

function! s:kanagawa_mini.hlgroups(colors, config) abort " {{{
  "let has_nvim = has('nvim')
  call self.h('ColorColumn', { 'bg': a:colors.bg_light0 })
  call self.h('Conceal', { 'fg': a:colors.bg_light3, 'gui': 'bold' })
  call self.h('Cursor', { 'fg': a:colors.bg, 'bg': a:colors.fg })
  call self.h('lCursor', { 'link': 'Cursor' })
  call self.h('CursorIM', { 'link': 'Cursor' })
  call self.h('CursorLine', { 'bg': a:colors.bg_light1 })
  call self.h('Directory', { 'fg': a:colors.fn })
  call self.h('DiffAdd', { 'bg': a:colors.diff.add })
  call self.h('DiffChange', { 'bg': a:colors.diff.change })
  call self.h('DiffDelete', { 'fg': a:colors.git.removed, 'bg': a:colors.diff.delete })
  call self.h('DiffText', { 'bg': a:colors.diff.text })
  call self.h('EndOfBuffer', { 'fg': a:colors.bg })
  "if self.has_nvim | call l:h('TermCursor', {}) | endif
  "if self.has_nvim | call l:h('TermCursor', {}) | endif
  call self.h('ErrorMsg', { 'fg': a:colors.diag.error })
  " NOTE:
  " httpl://github.com/rebelot/kanagawa.nvim/blob/4c8d48726621a7f3998c7ed35b2c2535abc22def/lua/kanagawa/hlgroups.lua#L50
  call self.h('VertSplit', { 'fg': a:colors.bg_dark, 'bg': a:config.dimInactive ? a:colors.bg_dark : 'NONE' })
  call self.h('Folded', { 'fg': a:colors.bg_light3, 'bg': a:colors.bg_light0 })
  call self.h('FoldColumn', { 'fg': a:colors.bg_light2 })
  call self.h('SignColumn', { 'fg': a:colors.bg_light2 })
  " TODO: I couldn't find any docs on this highlight group...
  " call self.h('SignColumnSB', { 'link': 'SignColumn' })
  "if self.has_nvim | call l:h('Substitute', { 'fg': a:colors.fg, 'bg': a:colors.git.removed }) | endif
  call self.h('LineNr', { 'fg': a:colors.bg_light2 })
  call self.h('CursorLineNr', { 'fg': a:colors.diag.warning, 'gui': 'bold' })
  call self.h('MatchParen', { 'fg': a:colors.diag.warning, 'gui': 'bold' })
  call self.h('ModeMsg', { 'fg': a:colors.diag.warning, 'gui': 'bold'})
  "if self.has_nvim | call l:h('MsgArea', { 'fg': a:colors.fg_dark }) | endif
  " nvim:MsgSeparator
  call self.h('MoreMsg', { 'fg': a:colors.diag.info, 'bg': a:colors.bg })
  call self.h('NonText', { 'fg': a:colors.bg_light2 })
  call self.h('Normal', { 'fg': a:colors.fg, 'bg': !a:config.transparent ? a:colors.bg : 'NONE' })
  "if self.has_nvim | call l:h('NormalNC', a:config.dimInactive ? { 'fg': a:colors.fg_dark, 'bg': a:colors.bg_dim } : { 'link': 'Normal' }) | endif
  "if self.has_nvim | call l:h('NormalSB', { 'link': 'Normal' }) | endif
  "if self.has_nvim | call l:h('NormalFloat', { 'fg': a:colors.fg_dark, 'bg': a:colors.bg_dark }) | endif
  "if self.has_nvim | call l:h('FloatBorder', { 'fg': a:colors.fg_border, 'bg': a:colors.bg_dark }) | endif
  "if self.has_nvim | call l:h('FloatTitle', { 'fg': a:colors.bg_light3, 'bg': a:colors.bg_dark, 'gui': 'bold' }) | endif
  call self.h('Pmenu', { 'fg': a:colors.fg_menu, 'bg': a:colors.bg_menu })
  call self.h('PmenuSel', { 'fg': 'NONE', 'bg': a:colors.bg_menu_sel })
  call self.h('PmenuSbar', { 'link': 'Pmenu' })
  call self.h('PmenuThumb', { 'bg': a:colors.bg_search })
  call self.h('Question', { 'link': 'MoreMsg' })
  call self.h('QuickFixLine', { 'link': 'CursorLine' })
  call self.h('Search', { 'fg': a:colors.fg, 'bg': a:colors.bg_search })
  "if self.has_nvim | call l:h('CurSearch', { 'link': 'Search' }) | endif
  call self.h('IncSearch', { 'fg': a:colors.bg_visual, 'bg': a:colors.diag.warning })
  call self.h('SpecialKey', { 'link': 'NonText' })
  call self.h('SpellBad', { 'sp': a:colors.diag.error, 'gui': 'undercurl' })
  call self.h('SpellCap', { 'sp': a:colors.diag.warning, 'gui': 'undercurl' })
  call self.h('SpellLocal', { 'sp': a:colors.diag.warning, 'gui': 'undercurl' })
  call self.h('SpellRare', { 'sp': a:colors.diag.warning, 'gui': 'undercurl' })
  call self.h('StatusLine', { 'fg': a:colors.fg_dark, 'bg': a:colors.bg_status })
  call self.h('StatusLineNC', { 'fg': a:colors.fg_comment, 'bg': a:colors.bg_status })
  "if self.has_nvim | call l:h('Winbar', { 'fg': a:colors.fg_dark, 'bg': 'NONE' }) | endif
  "if self.has_nvim | call l:h('WinbarNC', { 'fg': a:colors.fg_dark, 'bg': a:config.dimInactive ? a:colors.bg_dim : 'NONE' }) | endif
  call self.h('TabLine', { 'bg': a:colors.bg_dark, 'fg': a:colors.bg_light3 })
  call self.h('TabLineFill', { 'bg': a:colors.bg })
  call self.h('TabLineSel', { 'fg': a:colors.fg_dark, 'bg': a:colors.bg_light1 })
  call self.h('Title', { 'fg': a:colors.fn, 'gui': 'bold' })
  call self.h('Visual', { 'bg': a:colors.bg_visual })
  call self.h('VisualNOS', { 'link': 'Visual' })
  call self.h('WarningMsg', { 'fg': a:colors.diag.warning })
  "if self.has_nvim | call l:h('Whitespace', { 'fg': a:colors.bg_light2 }) | endif
  call self.h('WildMenu', { 'link': 'Pmenu' })

  call self.h('Comment', { 'fg': a:colors.fg_comment })

  call self.h('Constant', { 'fg': a:colors.co })
  call self.h('String', { 'fg': a:colors.st })
  call self.h('Character', { 'link': 'String' })
  call self.h('Number', { 'fg': a:colors.nu })
  call self.h('Boolean', { 'fg': a:colors.co, 'gui': 'bold' })
  call self.h('Float', { 'link': 'Number' })

  call self.h('Identifier', { 'fg': a:colors.id })
  call self.h('Function', { 'fg': a:colors.fn, 'gui': a:config.functionStyle })

  call self.h('Statement', { 'fg': a:colors.sm, 'gui': a:config.statementStyle })
  " Conditional
  " Repeat
  " Label
  call self.h('Operator', { 'fg': a:colors.op })
  call self.h('Keyword', { 'fg': a:colors.kw, 'gui': a:config.keywordStyle })
  call self.h('Exception', { 'fg': a:colors.sp2 })

  call self.h('PreProc', { 'fg': a:colors.pp })
  " Include
  " Define
  " Precondit

  call self.h('Type', { 'fg': a:colors.ty, 'gui': a:config.typeStyle })
  " StorageClass
  " Structure
  " Typedef

  call self.h('Special', { 'fg': a:colors.sp })
  " SpecialChar
  " Tag
  " Delimiter
  " SpecialComment
  " Debug

  call self.h('Underlined', { 'fg': a:colors.sp, 'gui': 'underline' })

  call self.h('Ignore', { 'link': 'NonText' })

  call self.h('Error', { 'fg': a:colors.diag.error })

  call self.h('ToDo', { 'fg': a:colors.fg_reverse, 'bg': a:colors.diag.info, 'gui': 'bold' })

  "call self.h('Method', { 'link': 'Function' })
  "call self.h('Structure', { 'link': 'Type' })
  "call self.h('Bold', { 'gui': 'bold' })
  "call self.h('Italic', { 'gui': 'italic' })
endfunction " }}}

function! g:SetMyColorScheme() abort " {{{
  set bg=dark
  hi clear

  if exists("syntax_on")
    syntax reset
  endif
  let s:kanagawa_mini.config = s:kanagawa_mini.get_config(get(g:, 'kanagawa_mini', {}))
  if !exists('g:kanagawa_mini')
    let g:kanagawa_mini = s:kanagawa_mini.config
  endif
  let s:kanagawa_mini.palette = s:kanagawa_mini.get_palette(s:kanagawa_mini.config.theme)
  let s:kanagawa_mini.colors = s:kanagawa_mini.get_colors(s:kanagawa_mini.palette)
  if s:kanagawa_mini.config.terminalColors
    call s:kanagawa_mini.set_terminal_ansi_colors(s:kanagawa_mini.palette)
  endif
  call s:kanagawa_mini.hlgroups(s:kanagawa_mini.colors, s:kanagawa_mini.config)
endfunction " }}}

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

nnoremap H ^
nnoremap L $
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

nnoremap <Leader>h :<C-u>set hlsearch!<CR>:set hlsearch?<CR>

nnoremap x "_x

inoremap <C-Tab> <Tab>

nnoremap <silent> <S-Up> "zdd<Up>"zP
nnoremap <silent> <S-Down> "zdd"zp
vnoremap <S-Up> "zx<Up>"zP`[V`]
vnoremap <S-Down> "zx"zp`[V`]
" * * }}}
" * * [explorer](netrw): {{{
nmap <leader>e [explorer]
nnoremap [explorer] <Nop>
nnoremap <silent> [explorer]e :<C-u>call ToggleVExplorer()<CR>
" * * }}}
" * * [buffer]: {{{
nmap <Leader>b [buffer]
nnoremap [buffer] <Nop>
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
  call g:SetMyColorScheme()
  "colorscheme kanagawa-mini
catch
  colorscheme desert
endtry

" call g:Init()
" colorscheme kanagawa-mini
filetype plugin indent on
" * }}}
" vim: set ft=vim ts=2 sts=-1 sw=0 et fdm=marker fmr={{{,}}} cms="\ %s:

