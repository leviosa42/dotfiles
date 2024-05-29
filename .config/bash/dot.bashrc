#!/bin/bash

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

# _info "Setting up shell options..."
: "Shell options" && {
  # autocd ... cd to directory by just typing the directory name
  shopt -s autocd
  # cdspell ... corrects minor spelling errors during cd
  shopt -s cdspell
  # direxpand ... expands directory names to the full pathname
  shopt -s direxpand
  # dirspell ... corrects minor spelling errors during directory name completion
  shopt -s dirspell
  # dotglob ... include hidden files in globbing
  shopt -s dotglob
  # extglob ... enable extended pattern matching features
  shopt -s extglob
  # histappend ... append to the history file, don't overwrite it
  shopt -s histappend
}

# _info "Setting up environment variables..."
: "Set Enviroment Variables" && {
  # DOTFILES_DIR
  export DOTFILES_DIR="$HOME/.dotfiles"

  # XDG Base Directory Specification
  set -a && source "$DOTFILES_DIR/.config/bash/env.xdg.sh" && set +a

  # history
  export HISTSIZE=1000
  export HISTCONTROL=ignoreboth

  # PATH
  if [[ -d $CARGO_HOME && -f ${CARGO_HOME}/env ]]; then
    source "${CARGO_HOME}/env"
  fi
  # [ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
  if [[ -f $CARGO_HOME/bin ]]; then
    $PATH="$CARGO_HOME/bin$PATH"
  fi
  if [[ ! $PATH =~ "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
  fi
  if [[ ! $PATH =~ "/usr/local/go/bin" ]]; then
    export PATH="$PATH:/usr/local/go/bin"
  fi
  if [[ ! $PATH =~ "$HOME/go/bin" ]]; then
    export PATH="$PATH:$HOME/go/bin"
  elif [[ ! $PATH =~ "$XDG_DATA_HOME/go/bin" ]]; then
    export PATH="${PATH}:$XDG_DATA_HOME/go/bin"
  fi

  # others
  export EDITOR="nvim"
  export VISUAL="$EDITOR"

  # wsl
  if [[ -v WSL_DISTRO_NAME ]]; then
    export BROWSER=/mnt/c/windows/explorer.exe
  fi

  # lambdalisue/vim-manpager
	export MANPAGER="vim -c ASMANPAGER -"
}

# _info "Setting up shell prompt..."
: "Set Prompt" && {
  # export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
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

    if [[ -v VIM_TERMINAL ]]; then
        shell_name="vim:${shell_name}"
    fi

    if [[ -v WSL_DISTRO_NAME ]]; then
        shell_name="wsl:${shell_name}"
    fi

    if [ -e /.dockerenv ]; then
      shell_name="docker:${shell_name}"
    fi

    # if [ -f /etc/os-release ]; then
    #   . /etc/os-release
    #   local distro_icon=${NAME}
    #   case ${NAME} in
    #     "Ubuntu")
    #       distro_icon_NF="󰕈 " # U+f0548 nf-md-ubuntu
    #       ;;
    #     "Arch Linux")
    #       distro_icon_NF="󰣇 " # U+f08c7 nf-md-arch 
    #       ;;
    #     *)
    #       distro_icon_NF=""
    #       ;;
    #   esac
    #   shell_name="${distro_icon_NF}${shell_name}"
    # fi

    # export PS1="(\s $SHLVL)\[\e[1;33m\]\w\[\e[00m\]\$ "
    export PS1="${res}(${exitcolor}${shell_name} ${SHLVL}${res}${bg})${yel}\w${res}:\\$ ${bg}"
  }
  _set_ps1
  export PROMPT_COMMAND="_set_ps1"
}

# _info "Setting up shell aliases..."
: "Set Aliases" && {
  source "$DOTFILES_DIR/.config/sh/aliases.sh"
  alias rebash="exec $SHELL -l"
  # XDG Base Directory Specification
  alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget/hsts"
  alias "clip.exe"="/mnt/c/WINDOWS/system32/clip.exe"
  alias "code"="/mnt/c/Users/askm4/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
}

# _info "Change terminal color..."
: "Change terminal color" || {
  # tokyonight.sh
  # see: https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Operating-System-Commands

  # set -euo pipefail

  : "Define functions" && {
    function osc() {
      # Usage:
      #   osc <sequence_number> <text1> <text2> ...
      # Example:
      #   osc 1 'This is title' # == printf "\033]1;This is title\033\\"
      local IFS=';'
      printf "\033]$*\033\\"
      return 0
    }
  }

  : "Define colors" && {
    BLACK='#15161e'
    RED='#f7768e'
    GREEN='#9ece6a'
    YELLOW='#e0af68'
    BLUE='#7aa2f7'
    PURPLE='#bb9af7'
    CYAN='#7dcfff'
    WHITE='#a9b1d6'
    BRIGHT_BLACK='#414868'
    BRIGHT_RED='#f7768e'
    BRIGHT_GREEN='#9ece6a'
    BRIGHT_YELLOW='#e0af68'
    BRIGHT_BLUE='#7aa2f7'
    BRIGHT_PURPLE='#9d7cd8'
    BRIGHT_CYAN='#7dcfff'
    BRIGHT_WHITE='#c0caf5'
    FOREGROUND='#c0caf5'
    BACKGROUND='#1a1b26'
    CURSOR="${BLUE}"
  }

  : "Set colors" && {
    osc 4 0 "${BLACK}"
    osc 4 1 "${RED}"
    osc 4 2 "${GREEN}"
    osc 4 3 "${YELLOW}"
    osc 4 4 "${BLUE}"
    osc 4 5 "${PURPLE}"
    osc 4 6 "${CYAN}"
    osc 4 7 "${WHITE}"
    osc 4 8 "${BRIGHT_BLACK}"
    osc 4 9 "${BRIGHT_RED}"
    osc 4 10 "${BRIGHT_GREEN}"
    osc 4 11 "${BRIGHT_YELLOW}"
    osc 4 12 "${BRIGHT_BLUE}"
    osc 4 13 "${BRIGHT_PURPLE}"
    osc 4 14 "${BRIGHT_CYAN}"
    osc 4 15 "${BRIGHT_WHITE}"
    osc 10 "${FOREGROUND}"
    osc 11 "${BACKGROUND}"
    osc 12 "${CURSOR}"
  }
}

# _info "Setting up useful functions..."
: "Useful functions" && {
  function colortest() {
    # https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
    local T='gYw' # The test text
    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
    echo -e "\n                1;40m   1;41m   1;42m   1;43m   1;44m   1;45m   1;46m   1;47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
      do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
      for BG in 100m 101m 102m 103m 104m 105m 106m 107m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
  };
  function mkcd() {
    if [[ $# == 0 ]]; then
      echo "Usage: mkcd <directory>" >&2
      return 1
    elif [[ $# > 1 ]]; then
      echo "Specify only one directory" >&2
      return 1
    fi
    mkdir -p "$1" && cd "$1";
    return 0;
  };
}

# If .bashrc.local exists, source it
if [ -f "$HOME/.bashrc.local" ]; then
  # _info "Sourcing .bashrc.local..."
  source "$HOME/.bashrc.local"
fi

_info "Loaded .bashrc"

return 0

# vim: set ft=sh ts=2 sw=0 sts=-1 et fdm=marker fmr={,}:
