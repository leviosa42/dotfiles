#!/usr/bin/env bash

# If not running interactivty don't do anything
[ -z "$PS1" ] && return
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
source ".bash/rc/alias.bash"

