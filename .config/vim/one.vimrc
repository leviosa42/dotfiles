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

set rtp+=~/vim-dev/vim-xvi,~/vim-dev/kanagawa-mini.vim
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
let &guifont = 'PlemolJP Console NF:h13'
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
" * * StatusLine: {{{
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
" * * ColorScheme: {{{
function! g:SetMyColorScheme() abort
  " kanagawa-mini.vim
  set bg=dark
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
  " palette: {{{
  let s:p = {
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
  " }}}
  " terminal_ansi_colors: {{{
  let g:terminal_ansi_colors = [
      \ '#090618',
      \ s:p.autumnRed,
      \ s:p.autumnGreen,
      \ s:p.boatYellow2,
      \ s:p.crystalBlue,
      \ s:p.oniViolet,
      \ s:p.waveAqua1,
      \ s:p.oldWhite,
      \ s:p.fujiGray,
      \ s:p.samuraiRed,
      \ s:p.springGreen,
      \ s:p.carpYellow,
      \ s:p.springBlue,
      \ s:p.springViolet1,
      \ s:p.waveAqua2,
      \ s:p.fujiWhite,
      \ ]
  " }}}
  " config: {{{
  let g:kanagawa_mini_vim = {}
  let s:config = extend({
    \ 'undercurl': v:true,
    \ 'commentStyle': 'italic',
    \ 'functionStyle': 'NONE',
    \ 'keywordStyle': 'italic',
    \ 'statementStyle': 'bold',
    \ 'typeStyle': 'NONE',
    \ 'variablebuiltinStyle': 'italic',
    \ 'specialReturn': v:true,
    \ 'specialExeption': v:true,
    \ 'transparent': v:false,
    \ 'dimInactive': v:false,
    \ 'globalSTatus': v:false,
    \ 'terminalColors': v:true,
    \ 'colors': {},
    \ 'overrides': {},
    \ 'theme': 'default'
    \ }, get(g:, 'kanagawa_mini_vim', {}))
  " }}}
  " colors: {{{
  let s:colors = {
    \ 'bg' : s:p.sumiInk1,
    \ 'bg_dim' : s:p.sumiInk1b,
    \ 'bg_dark' : s:p.sumiInk0,
    \ 'bg_light0' : s:p.sumiInk2,
    \ 'bg_light1' : s:p.sumiInk3,
    \ 'bg_light2' : s:p.sumiInk4,
    \ 'bg_light3' : s:p.springViolet1,
    \ 'bg_menu' : s:p.waveBlue1,
    \ 'bg_menu_sel' : s:p.waveBlue2,
    \ 'bg_status' : s:p.sumiInk0,
    \ 'bg_visual' : s:p.waveBlue1,
    \ 'bg_search' : s:p.waveBlue2,
    \ 'fg_border' : s:p.sumiInk4,
    \ 'fg_dark' : s:p.oldWhite,
    \ 'fg_reverse' : s:p.waveBlue1,
    \ 'fg_comment' : s:p.fujiGray,
    \ 'fg' : s:p.fujiWhite,
    \ 'fg_menu' : s:p.fujiWhite,
    \ 'co' : s:p.surimiOrange,
    \ 'st' : s:p.springGreen,
    \ 'nu' : s:p.sakuraPink,
    \ 'id' : s:p.carpYellow,
    \ 'fn' : s:p.crystalBlue,
    \ 'sm' : s:p.oniViolet,
    \ 'kw' : s:p.oniViolet,
    \ 'op' : s:p.boatYellow2,
    \ 'pp' : s:p.surimiOrange,
    \ 'ty' : s:p.waveAqua2,
    \ 'sp' : s:p.springBlue,
    \ 'sp2' : s:p.waveRed,
    \ 'sp3' : s:p.peachRed,
    \ 'br' : s:p.springViolet2,
    \ 're' : s:p.boatYellow2,
    \ 'dep' : s:p.katanaGray,
    \ 'diag' : {
    \ 'error' : s:p.samuraiRed,
    \ 'warning' : s:p.roninYellow,
    \ 'info' : s:p.dragonBlue,
    \ 'hint' : s:p.waveAqua1,
    \ },
    \ 'diff' : {
    \ 'add' : s:p.winterGreen,
    \ 'delete' : s:p.winterRed,
    \ 'change' : s:p.winterBlue,
    \ 'text' : s:p.winterYellow,
    \ },
    \ 'git' : {
    \ 'added' : s:p.autumnGreen,
    \ 'removed' : s:p.autumnRed,
    \ 'changed' : s:p.autumnYellow,
    \ },
  \ }
  " }}}
  " funcs: {{{
  function! s:h(group, style) abort
    if empty(a:style)
      return
    endif
    if has_key(a:style, 'link')
      execute 'hi' 'link' a:group a:style.link
      return
    endif
    execute 'hi' a:group
      \ 'guibg=' . (has_key(a:style, 'bg')  ? a:style.bg  : 'NONE')
      \ 'guifg=' . (has_key(a:style, 'fg')  ? a:style.fg  : 'NONE')
      \ 'guisp=' . (has_key(a:style, 'sp')  ? a:style.sp  : 'NONE')
      \ 'gui='   . (has_key(a:style, 'gui') ? a:style.gui : 'NONE')
  endfunction
  " }}}
  " highlight: {{{
  let s:has_nvim = has('nvim')

  call s:h('ColorColumn', { 'bg': s:colors.bg_light0 })
  call s:h('Conceal', { 'fg': s:colors.bg_light3, 'gui': 'bold' })
  call s:h('Cursor', { 'fg': s:colors.bg, 'bg': s:colors.fg })
  call s:h('lCursor', { 'link': 'Cursor' })
  call s:h('CursorIM', { 'link': 'Cursor' })
  call s:h('CursorLine', { 'bg': s:colors.bg_light1 })
  call s:h('Directory', { 'fg': s:colors.fn })
  call s:h('DiffAdd', { 'bg': s:colors.diff.add })
  call s:h('DiffChange', { 'bg': s:colors.diff.change })
  call s:h('DiffDelete', { 'fg': s:colors.git.removed, 'bg': s:colors.diff.delete })
  call s:h('DiffText', { 'bg': s:colors.diff.text })
  call s:h('EndOfBuffer', { 'fg': s:colors.bg })
  "if s:has_nvim | call s:h('TermCursor', {}) | endif
  "if s:has_nvim | call s:h('TermCursor', {}) | endif
  call s:h('ErrorMsg', { 'fg': s:colors.diag.error })
  call s:h('VertSplit', { 'link': 'WinSeparator' })
  " TODO: nvim:WinSeparator
  call s:h('Folded', { 'fg': s:colors.bg_light3, 'bg': s:colors.bg_light0 })
  call s:h('FoldColumn', { 'fg': s:colors.bg_light2 })
  call s:h('SignColumn', { 'fg': s:colors.bg_light2 })
  " TODO: I couldn't find any docs on this highlight group...
  " call s:h('SignColumnSB', { 'link': 'SignColumn' })
  " if s:has_nvim | call s:h('Substitute', { 'fg': s:colors.fg, 'bg': s:colors.git.removed }) | endif
  call s:h('LineNr', { 'fg': s:colors.bg_light2 })
  call s:h('CursorLineNr', { 'fg': s:colors.diag.warning, 'gui': 'bold' })
  call s:h('MatchParen', { 'fg': s:colors.diag.warning, 'gui': 'bold' })
  call s:h('ModeMsg', { 'fg': s:colors.diag.warning, 'gui': 'bold'})
  " if s:has_nvim | call s:h('MsgArea', { 'fg': s:colors.fg_dark }) | endif
  " nvim:MsgSeparator
  call s:h('MoreMsg', { 'fg': s:colors.diag.info, 'bg': s:colors.bg })
  call s:h('NonText', { 'fg': s:colors.bg_light2 })
  call s:h('Normal', { 'fg': s:colors.fg, 'bg': !s:config.transparent ? s:colors.bg : 'NONE' })
  " if s:has_nvim | call s:h('NormalNC', s:config.dimInactive ? { 'fg': s:colors.fg_dark, 'bg': s:colors.bg_dim } : { 'link': 'Normal' }) | endif
  " if s:has_nvim | call s:h('NormalSB', { 'link': 'Normal' }) | endif
  " if s:has_nvim | call s:h('NormalFloat', { 'fg': s:colors.fg_dark, 'bg': s:colors.bg_dark }) | endif
  " if s:has_nvim | call s:h('FloatBorder', { 'fg': s:colors.fg_border, 'bg': s:colors.bg_dark }) | endif
  " if s:has_nvim | call s:h('FloatTitle', { 'fg': s:colors.bg_light3, 'bg': s:colors.bg_dark, 'gui': 'bold' }) | endif
  call s:h('Pmenu', { 'fg': s:colors.fg_menu, 'bg': s:colors.bg_menu })
  call s:h('PmenuSel', { 'fg': 'NONE', 'bg': s:colors.bg_menu_sel })
  call s:h('PmenuSbar', { 'link': 'Pmenu' })
  call s:h('PmenuThumb', { 'bg': s:colors.bg_search })
  call s:h('Question', { 'link': 'MoreMsg' })
  call s:h('QuickFixLine', { 'link': 'CursorLine' })
  call s:h('Search', { 'fg': s:colors.fg, 'bg': s:colors.bg_search })
  " if s:has_nvim | csll s:h('CurSearch', { 'link': 'Search' }) | endif
  call s:h('IncSearch', { 'fg': s:colors.bg_visual, 'bg': s:colors.diag.warning })
  call s:h('SpecialKey', { 'link': 'NonText' })
  call s:h('SpellBad', { 'sp': s:colors.diag.error, 'gui': 'undercurl' })
  call s:h('SpellCap', { 'sp': s:colors.diag.warning, 'gui': 'undercurl' })
  call s:h('SpellLocal', { 'sp': s:colors.diag.warning, 'gui': 'undercurl' })
  call s:h('SpellRare', { 'sp': s:colors.diag.warning, 'gui': 'undercurl' })
  call s:h('StatusLine', { 'fg': s:colors.fg_dark, 'bg': s:colors.bg_status })
  call s:h('StatusLineNC', { 'fg': s:colors.fg_comment, 'bg': s:colors.bg_status })
  " if s:has_nvim | call s:h('Winbar', { 'fg': s:colors.fg_dark, 'bg': 'NONE' }) | endif
  " if s:has_nvim | call s:h('WinbarNC', { 'fg': s:colors.fg_dark, 'bg': s:config.dimInactive ? s:colors.bg_dim : 'NONE' }) | endif
  call s:h('TabLine', { 'bg': s:colors.bg_dark, 'fg': s:colors.bg_light3 })
  call s:h('TabLineFill', { 'bg': s:colors.bg })
  call s:h('TabLineSel', { 'fg': s:colors.fg_dark, 'bg': s:colors.bg_light1 })
  call s:h('Title', { 'fg': s:colors.fn, 'gui': 'bold' })
  call s:h('Visual', { 'bg': s:colors.bg_visual })
  call s:h('VisualNOS', { 'link': 'Visual' })
  call s:h('WarningMsg', { 'fg': s:colors.diag.warning })
  " if s:has_nvim | call s:h('Whitespace', { 'fg': s:colors.bg_light2 }) | endif
  call s:h('WildMenu', { 'link': 'Pmenu' })

  call s:h('Comment', { 'fg': s:colors.fg_comment })

  call s:h('Constant', { 'fg': s:colors.co })
  call s:h('String', { 'fg': s:colors.st })
  call s:h('Character', { 'link': 'String' })
  call s:h('Number', { 'fg': s:colors.nu })
  call s:h('Boolean', { 'fg': s:colors.co, 'gui': 'bold' })
  call s:h('Float', { 'link': 'Number' })

  call s:h('Identifier', { 'fg': s:colors.id })
  call s:h('Function', { 'fg': s:colors.fn, 'gui': s:config.functionStyle })

  call s:h('Statement', { 'fg': s:colors.sm, 'gui': s:config.statementStyle })
  " Conditional
  " Repeat
  " Label
  call s:h('Operator', { 'fg': s:colors.op })
  call s:h('Keyword', { 'fg': s:colors.kw, 'gui': s:config.keywordStyle })
  call s:h('Exception', { 'fg': s:colors.sp2 })

  call s:h('PreProc', { 'fg': s:colors.pp })
  " Include
  " Define
  " Precondit

  call s:h('Type', { 'fg': s:colors.ty, 'gui': s:config.typeStyle })
  " StorageClass
  " Structure
  " Typedef

  call s:h('Special', { 'fg': s:colors.sp })
  " SpecialChar
  " Tag
  " Delimiter
  " SpecialComment
  " Debug

  call s:h('Underlined', { 'fg': s:colors.sp, 'gui': 'underline' })

  call s:h('Ignore', { 'link': 'NonText' })

  call s:h('Error', { 'fg': s:colors.diag.error })

  call s:h('ToDo', { 'fg': s:colors.fg_reverse, 'bg': s:colors.diag.info, 'gui': 'bold' })
  " }}}
endfunction
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
" * Post Init: {{{
syntax enable
set background=dark
try
  call g:SetMyColorScheme()
catch
  colorscheme desert
endtry
" colorscheme kanagawa-mini
filetype plugin indent on
" * }}}
" vim: set ft=vim ts=2 sts=-1 sw=0 et fdm=marker fmr={{{,}}} cms="\ %s:

