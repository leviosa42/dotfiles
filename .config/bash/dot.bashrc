#!/usr/bin/env bash

# If not running interactivty don't do anything
[ -z "$PS1" ] && return
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#export PS1='\[\e[1;36m\]\u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;33m\]\w\[\e[00m\]\$ '

set_ps1() {
    local shell_name=$(basename $0)

    export PS1=($shell_name $SHLVL)'\[\e[1;33m\]\w\[\e[00m\]\$ '
}
set_ps1

#if [[ -v MSYSTEM ]]; then
#  export VIM=/mingw64/share/vim
#  echo $VIM
#  export VIMRUNTIME=/mingw64/share/vim/runtime
#  echo $VIMRUNTIME
#fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

alias "clip.exe"="/mnt/c/WINDOWS/system32/clip.exe"

export XDG_CONFIG_HOME="$HOME/.config"

export DOTFILES="$HOME/dotfiles"

# for git-bash
#export PATH=`cygpath -u $PATH`

source "$DOTFILES/.config/sh/env.sh"
source "$DOTFILES/.config/sh/aliases.sh"

#eval "$(starship init bash)"
