" === autocmds ===
" --- 'keywordprg' by filetype ---
augroup KeywordprgByFileType
  autocmd!
  autocmd FileType vim setl kp=:help
  autocmd FileType sh  setl kp=man
        \ | nnoremap K :Man <cword><CR>
augroup END

" --- indentation by filetype ---
augroup IndentationByFileType
  autocmd!
  autocmd FileType vim setl ts=2 et
  autocmd FileType sh  setl ts=2 et
  autocmd FileType c   setl ts=4 noet cindent
  autocmd FileType man setl ts=4
  " autocmd FileType dotbatch setl ts=4 noet fenc=shift_jis
augroup END

" --- 'makeprg' by filetype ---
augroup MakeprgByFileType
  autocmd!
  autocmd FileType c setl mp=gcc\ %
augroup END

" --- 'commentstring' by filetype ---
augroup CommentstringByFileType
  autocmd!
  autocmd FileType vim setl cms=\"\ %s
  autocmd FileType sh  setl cms=#\ %s
  autocmd FileType c   setl cms=//\ %s
augroup END

augroup Man
  autocmd!
  autocmd FileType man
        \ | setl nolist nonumber nomodifiable readonly noswapfile
        \ | if !empty($MAN_PN) | file $MAN_PN endif
augroup END

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \ if &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif

