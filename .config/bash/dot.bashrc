#!/usr/bin/env bash

# If not running interactivty don't do anything
# [ -z "$PS1" ] && return 0
# [[ -v PS1 ]] || return 0 # for 'unbound variable'
[[ ! $- =~ i ]] && return 0

: "Libraries" && {
  # log functions
  function _debug() {
    echo -e "\[\e[34m\][DEBG]\[\e[0m\] $1"
  }
  function _info() {
    echo -e "[\e[32mINFO\e[0m] $1"
  }
  # OSC
  function osc(){
    # Usage:
    #   osc <sequence_number> <text>
    # Example:
    #   osc 1 'This is title' # == printf "\033]1;This is title\033\\"
    [[ $1 =~ 'd' ]] && set -x
    local IFS=';'
    printf "\033]$*\033\\"
    [[ $1 =~ 'd' ]] && set +x
    
    return 0
  }
}

_info "Setting up environment variables..."
: "Set Enviroment Variables" && {
source "$DOTFILES_DIR/.config/sh/env.sh"
  # XDG_*_HOME
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_STATE_HOME="$HOME/.local/state"
  # DOTFILES_DIR
  export DOTFILES_DIR="$HOME/.dotfiles"
  # PATH
  [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
}

: "Set Prompt" && {
  #export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
  #export PS1='\[\e[1;36m\]\u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;33m\]\w\[\e[00m\]\$ '
  function _set_ps1() {
    local exst=$? # exit status
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

    local red="$(echo -e '\[\e[31m\]')"
    local yel="$(echo -e '\[\e[33m\]')"
    local cya="$(echo -e '\[\e[36m\]')"
    local res="$(echo -e '\[\e[00m\]')"
    local bg="$(echo -e '\[\e[49m\]')"
    # \s .. shell name

    # shell_name
    local shell_name='\s'
    # exitcolor
    if [[ $exst == 0 ]]; then
      local exitcolor=$cya
    else
      local exitcolor=$red
    fi

    if [[ -v WSL_DISTRO_NAME ]]; then
        shell_name="wsl:${shell_name}"
    fi

    if [ -e /.dockerenv ]; then
      shell_name="docker:${shell_name}"
    fi

    # export PS1="(\s $SHLVL)\[\e[1;33m\]\w\[\e[00m\]\$ "
    export PS1="${res}(${exitcolor}${shell_name} ${SHLVL}${res}${bg})${yel}\w${res}:\\$ ${bg}"
  }
  _set_ps1
  export PROMPT_COMMAND="_set_ps1"
}

: "Set Aliases" && {
  source "$DOTFILES_DIR/.config/sh/aliases.sh"
  alias "clip.exe"="/mnt/c/WINDOWS/system32/clip.exe"
}

# If .bashrc.local exists, source it
if [ -f "$HOME/.bashrc.local" ]; then
  _info "Sourcing .bashrc.local..."
  source "$HOME/.bashrc.local"
fi


# vim: set ft=sh ts=2 sw=0 sts=-1 et fdm=marker fmr={,}:
