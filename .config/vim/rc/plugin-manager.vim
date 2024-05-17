" === plugin manager(vim-jetpack) ===
" --- configuration for vim-jetpack ---
if executable('git')
  let g:jetpack_download_method = 'git'
elseif executable('curl')
  let g:jetpack_download_method = 'curl'
else
  let g:jetpack_download_method = 'wget'
endif
" --- automatic install if needed ---
let s:jetpackfile = expand('$XDG_DATA_HOME/vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim')
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  if g:jetpack_download_method != 'wget'
    call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
  else
    call mkdir(fnamemodify(s:jetpackfile, ':h'), 'p')
    call system(printf('wget -qO %s %s', s:jetpackfile, s:jetpackurl))
  endif
endif

" --- add plugins ---
packadd vim-jetpack
call jetpack#begin(expand('$XDG_DATA_HOME/vim'))
call jetpack#add('tani/vim-jetpack', {'opt': 1}) " bootstrap
call jetpack#add('vim-jp/vimdoc-ja') " help for japanese
call jetpack#add('dstein64/vim-startuptime') " help for japanese
call jetpack#add('tpope/vim-commentary') " comment in/out
call jetpack#add('markonm/traces.vim') " preview the replacement results
call jetpack#add('machakann/vim-highlightedyank') " flash yanked text
call jetpack#add('lambdalisue/vim-manpager') " manpager
call jetpack#add('lambdalisue/fern.vim') " filer
nnoremap [edit]e :Fern . -drawer -toggle -keep<CR>
nnoremap [edit]d :Fern %:h -drawer -toggle -keep<CR>
nnoremap <expr> [vimrc]d ":Fern " .. fnamemodify($MYVIMRC, ':h') .. " -drawer -toggle -keep\<CR>"
augroup FernStatusLine
  autocmd!
  autocmd FileType fern let &l:stl = '%#Directory# %{&ft} '
augroup END
call jetpack#add('leviosa42/vim-github-theme') " colorscheme
call jetpack#add('tomasr/molokai') " colorscheme
call jetpack#add('morhetz/gruvbox') " colorscheme
call jetpack#add('sainnhe/gruvbox-material') " colorscheme
call jetpack#add('altercation/vim-colors-solarized') " colorscheme
call jetpack#add('catppuccin/vim', {'name': 'catppuccin'}) " colorscheme
" call jetpack#add('nordtheme/vim', {'name': 'nord'}) " colorscheme
 " call jetpack#add('dracula/vim', {'name': 'dracula'}) " colorscheme
" call jetpack#add('ghifarit53/tokyonight-vim') " colorscheme
let g:tokyonight_style = 'night'
call jetpack#add('cocopon/iceberg.vim') " colorscheme
call jetpack#end()

" :h man.vim
" ref: https://muru.dev/2015/08/28/vim-for-man.html
" runtime! ftplugin/man.vim
let g:ft_man_folding_enable = 1
let g:ft_man_no_sect_fallback = 1

