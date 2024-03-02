#!/bin/bash

# XDG Base Directory Specification
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$UID}
XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:-/etc/xdg}

for var in XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME XDG_RUNTIME_DIR XDG_DATA_DIRS XDG_CONFIG_DIRS; do
  [ ! -d "${var}" ] && mkdir -p "${var}"
done
# bash
# NOTE: $XDG_CONFIG_HOME/bash/bashrc must be sourced from /etc/bash.bashrc.
# Append the following line to /etc/bash.bashrc:
#   . "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bashrc"
[ -d "$XDG_CONFIG_HOME/bash" ] && mkdir -p "$XDG_CONFIG_HOME/bash"
HISTFILE="$XDG_STATE_HOME/bash/history"
if [ ! -f $HISTFILE ]; then
  mkdir -p $(dirname $HISTFILE) && touch $HISTFILE
fi
tail /etc/bash.bashrc | grep -q 'XDG_CONFIG_HOME' || echo ". \"${XDG_CONFIG_HOME:-$HOME/.config}/bash/dot.bashrc\"" >> /etc/bash.bashrc

# go
mkdir -p "$XDG_DATA_HOME/go"
GOPATH=${GOPATH:-$XDG_DATA_HOME/go}

# rust(cargo,rustup)
# NOTE: Set CARGO_HOME and RUSTUP_HOME to support XDG Base Dir before installing Rust via rustup.
CARGO_HOME=${CARGO_HOME:-$XDG_DATA_HOME/cargo}
mkdir -p $CARGO_HOME
RUSTUP_HOME=${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}
mkdir -p $RUSTUP_HOME

# node.js
mkdir -p "$XDG_CONFIG_HOME/node"
NODE_REPL_HISTORY="$XDG_STATE_HOME/node/repl_history"

# vim
# NOTE: VIMINIT will also affect Neovim.
VIMINIT="if !has('nvim') | so $XDG_CONFIG_HOME/vim/dot.vimrc | else | so $XDG_CONFIG_HOME/nvim/init.lua | endif"
