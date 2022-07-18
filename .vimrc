" Be iMproved
set nocompatible

" 
let s:rcs = [
	\ '.vim/rc/general.vim',
	\ '.vim/rc/appearance.vim',
	\ '.vim/rc/plugins.vim'
	\ ]

for filename in s:rcs
	execute 'source' fnameescape(filename)
endfor