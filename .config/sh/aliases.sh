#!/usr/bin/env sh
# Aliases to avoid mistakes
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# ls
alias ls='ls -1 --sort=extension --color=auto'
alias ll='ls -lh'
alias la='ls -la'

# grep, fgrep, egrep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Editings
alias dotfiles='vim ~/dotfiles/'
alias .bashrc='vim ~/.bashrc && source ~/.bashrc'
alias .aliases='vim $XDG_CONFIG_HOME/sh/aliases.sh && source ~/.bashrc'

alias vi='vim -u NONE'

alias :q='exit'

alias cls=clear
alias clc=clear
