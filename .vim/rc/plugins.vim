call plug#begin()
	" Color Schemes
	Plug 'ghifarit53/tokyonight-vim', {'do': 'cp colors/* ~/.vim/colors/'}
	" Plugins
	Plug 'itchyny/lightline.vim'
	Plug 'jiangmiao/auto-pairs'
call plug#end()

let g:lightline = {
		\ 'colorscheme': 'tokyonight',
		\ }
