" === autocmds ===
augroup vimrc
  autocmd!

  " --- detect filetype ---
  autocmd BufNewFile,BufRead *.plt setfiletype gnuplot

  " --- 'commentstring'
  autocmd FileType gnuplot setl cms=#\ %s

  " --- 'keywordprg' ---
  autocmd FileType vim setl kp=:help
  autocmd FileType sh  setl kp=:Man
        " \ | nnoremap K :Man <cword><CR>

  " --- indentation by filetype ---
  autocmd FileType vim setl ts=2 et
  autocmd FileType sh  setl ts=2 et
  autocmd FileType c   setl ts=4 noet cindent
  autocmd FileType man setl ts=4
  " autocmd FileType dotbatch setl ts=4 noet fenc=shift_jis

  " --- 'makeprg' by filetype ---
  autocmd FileType c setl mp=gcc\ %

  autocmd FileType vim setl cms=\"\ %s
  autocmd FileType sh  setl cms=#\ %s
  autocmd FileType c   setl cms=//\ %s

  " --- man ---
  autocmd FileType man
        \ | setl nolist nonumber nomodifiable readonly noswapfile fdl=99
        \ | if !empty($MAN_PN) | file $MAN_PN | endif

  if exists("+omnifunc")
    autocmd Filetype *
          \ if &omnifunc == "" |
          \   setlocal omnifunc=syntaxcomplete#Complete |
          \ endif
  endif
augroup END

