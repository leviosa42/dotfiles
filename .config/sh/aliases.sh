#!/usr/bin/env sh
# Aliases to avoid mistakes
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# ls
alias ls='ls -1 -F --sort=extension --color=auto'
alias ll='ls -lh'
alias la='ls -la'

# eza
# https://github.com/eza-community/eza
if [[ $(command -v eza) ]]; then
  alias eza='eza -1 -F --sort=extension --time-style=long-iso'
  alias ex='eza'
  alias el='eza -hl'
  alias ea='eza -ahl'
  alias et='eza -T -L 3 -a -I "node_modules|.git|.cache" '
  alias eta='eza -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
fi

# grep, fgrep, egrep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Editings
alias dotfiles='vim ~/dotfiles/'
alias .bashrc='vim ~/.bashrc && source ~/.bashrc'
alias .aliases='vim $XDG_CONFIG_HOME/sh/aliases.sh && source ~/.bashrc'

alias e="$EDITOR"
alias vi='vim -u NONE'

alias :q='exit'
alias q='exit'

alias cls=clear
alias clc=clear
