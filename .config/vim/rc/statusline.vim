" === statusline ===
set laststatus=2
let s:stl = ''
" let s:stl .= '%-{%g:actual_curwin==win_getid(winnr())?"%#SignColumn#":"%#StatusLineNC#"%}'
let s:stl .= '%-{%g:actual_curwin==win_getid(winnr())?"%#Directory#":"%#StatusLineNC#"%}'
let s:stl .= ' %{mode()[0]} ' " mode
let s:stl .= '%-{%g:actual_curwin==win_getid(winnr())?&modified?"%#DiffAdd#":"%#StatusLine#":"%#StatusLineNC#"%}'
let s:stl .= ' '
let s:stl .= '%-F' " filename
let s:stl .= '%-m' " is modified
let s:stl .= '%-r' " is readonly
" let s:stl .= '%-h' " is help-page
let s:stl .= '%=' " separation point between left and right
let s:stl .= '%{%g:actual_curwin==win_getid(winnr())?"%#CursorLine#":"%#StatusLineNC#"%}'
" let s:stl .= ' '
" let s:stl .= '%y'
let s:stl .= ' '
let s:stl .= '%{&ft}'
let s:stl .= ' '
let s:stl .= '%{&et?"spc":"tab"}:%{&ts}'
let s:stl .= ' '
let s:stl .= '%{&fenc!=""?&fenc:&enc}'
let s:stl .= ' '
let s:stl .= '%{&ff=="dos"?"CRLF":&ff=="unix"?"LF":"CR"}' " show fileformat
let s:stl .= ' '
" let s:stl .= '%l,%c' " lines/columns
let s:stl .= '%p%%'
let s:stl .= ' '
let s:stl .= '%<'


set laststatus=2
let &statusline = s:stl

" TODO
if exists("$USE_VIMUX") && $USE_VIMUX == 1
  set showtabline=2
  let &tabline = s:stl
  set laststatus=0
  let &statusline = s:stl
endif

" set title
" let s:tst = ''
" let s:tst .= '%{&shell}'
" let &titlestring = s:tst

