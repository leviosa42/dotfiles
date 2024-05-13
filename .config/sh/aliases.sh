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
  alias __eza__="$(which eza)"
  alias eza='__eza__ --color=automatic -1F --group-directories-first -h --git --time-style=long-iso'
  alias ls='eza'
  alias ll='ls -l'
  alias la='ls -laa'
  alias lt="eza -a -T -L=3 -I='node_modules|.git|.cache'"
fi

# grep, fgrep, egrep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Editings
alias dotfiles="$EDITOR $DOTFILES_DIR"
alias .bashrc="$EDITOR $XDG_CONFIG_HOME/bash/dot.bashrc && source $XDG_CONFIG_HOME/bash/dot.bashrc"
alias .aliases='vim $XDG_CONFIG_HOME/sh/aliases.sh && source ~/.bashrc'

alias e="$EDITOR"
alias vi='vim -u NONE'

alias :q='exit'
alias q='exit'

alias cls=clear
alias clc=clear
