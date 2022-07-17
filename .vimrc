" Be iMproved
set nocompatible

" 
let s:rcs = [
	\ '.vim/rc/general.vim',
	\ '.vim/rc/appearance.vim'
	\ ]

for filename in s:rcs
	execute 'source' fnameescape(filename)
endfor
