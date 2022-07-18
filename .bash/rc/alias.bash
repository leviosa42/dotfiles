#!/usr/bin/env bash

echo './bash/aliases'

# Aliases to avoid mistakes
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# ls
alias ls='ls --sort=extension --color=auto'
alias ll='ls -lh'
alias la='ls -a'

# grep, fgrep, egrep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Editings
alias dotfiles='vim ~/dotfiles/'
alias .bashrc='vim ~/.bashrc && source ~/.bashrc'
alias .alias='vim ~/.bash/rc//alias.bash && source ~/.bashrc'
