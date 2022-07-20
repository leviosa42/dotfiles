" Be iMproved
set nocompatible

set runtimepath^=./.vim
set packpath^=./.vim
"
lcd $HOME 
let s:rcs = [
	\ './.vim/rc/general.vim',
	\ './.vim/rc/appearance.vim',
	\ './.vim/rc/plugins.vim',
	\ './.vim/rc/gui.vim'
	\ ]

for filename in s:rcs
	execute 'source' fnameescape(filename)
endfor
