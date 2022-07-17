" Be iMproved
set nocompatible

" 
let s:dirname = fnamemodify(expand('<sfile>'), ':h')
let s:rcs = [
	\ ]

for filename in s:rcs
	execute 'source' fnameescape(filename)
endfor
