if exists('g:loaded_asterm')
  finish
endif
let g:loaded_asterm = 1

function! s:asterm_startup()
  if exists("$ASTERM") && $ASTERM == 1
    unlet $ASTERM

    if exists("g:asterm_colorscheme")
      execute "colorscheme " .. g:asterm_colorscheme
    endif

    set noruler noshowcmd noshowmode
    set laststatus=0 showtabline=2

    let &l:tal = ""
    let &l:tal .= "%#Folded#"
    let &l:tal .= " %{mode()[0]} "
    let &l:tal .= "%#CursorLineFold#"
    let &l:tal .= " "
    let &l:tal .= "%-F"
    let &l:tal .= "%="
    let &l:tal .= "%#Folded#"
    let &l:tal .= " asterm "

    terminal
    only
  endif
endfunction

" command Asterm call <SID>asterm_startup()

augroup asterm
  autocmd!
  autocmd VimEnter * call <SID>asterm_startup()
augroup END
