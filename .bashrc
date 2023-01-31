#!/usr/bin/env bash

# If not running interactivty don't do anything
[ -z "$PS1" ] && return
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#export PS1='\[\e[1;36m\]\u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;33m\]\w\[\e[00m\]\$ '

export PS1='\[\e[1;33m\]\w\[\e[00m\]\$ '

#if [[ -v MSYSTEM ]]; then
#  export VIM=/mingw64/share/vim
#  echo $VIM
#  export VIMRUNTIME=/mingw64/share/vim/runtime
#  echo $VIMRUNTIME
#fi
source ".bash/rc/alias.bash"

