#!/usr/bin/env bash

# If not running interactivty don't do anything
[ -z "$PS1" ] && return
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#export PS1='\[\e[1;36m\]\u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;33m\]\w\[\e[00m\]\$ '

set_ps1() {
    #   COLOR      FG   |   BG
    # --------------------------
    # black .... \e[30m | \e[40m
    # red ...... \e[31m | \e[41m
    # green .... \e[32m | \e[42m
    # yellow ... \e[33m | \e[43m
    # blue  .... \e[34m | \e[44m
    # magenta .. \e[35m | \e[45m
    # cyan ..... \e[36m | \e[46m
    # white .... \e[37m | \e[47m

    # reset .... \e[00m

    local yel="$(echo -e '\[\e[33m\]')"
    local cya="$(echo -e '\[\e[36m\]')"
    local res="$(echo -e '\[\e[00m\]')"
    # \s .. shell name

    # export PS1="(\s $SHLVL)\[\e[1;33m\]\w\[\e[00m\]\$ "
    export PS1="(${cya}\s ${SHLVL}${res})${yel}\w${res}\$ "
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

echo ".bashrc is loaded!"

