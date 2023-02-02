#!/usr/bin/env sh

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
export XDG_DATA_HOME="$HOME/.local/share"
mkdir -p "$XDG_DATA_HOME"
export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p "$XDG_CACHE_HOME"

# Shell Tools
export EDITOR="vim"
export VISUAL="vim"

#export VIM="$XDG_CONFIG_HOME/vim"
#export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

# MSYS2
#export MSYS2_PATH_TYPE=inherit

# Git
export GIT_EDITOR="vim"
export GIT_PAGER="less -R"
