#!/bin/bash

set -euo pipefail

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
DOTFILES_ROOTDIR=${DOTFILES_ROOTDIR:-$HOME/.dotfiles}

sources=(
  .config/alacritty
  .config/ash
  .config/bash
  .config/git
  .config/nvim
  # .config/nyagos
  .config/sh
  .config/vim
  # .config/wget
  .config/wezterm
  # .config/wt
	.config/npm
)

backup_dir=$XDG_CACHE_HOME/dotfiles/$(date "+%Y-%m-%d-%H%M%S")
mkdir -p $backup_dir

mkdir -p $XDG_CONFIG_HOME
for s in "${sources[@]}"; do
  source=$DOTFILES_ROOTDIR/$s
	target=${HOME}/${s}
	echo -e "\033[0;32m$source -> $target\033[0m"
  if [ -e $target ]; then
    backupto=$backup_dir/$s
    mkdir -p $(dirname $backupto)
    cp -r $source $backupto || echo "FAILURE to backup $source"
  fi
  ln -sfn $source $target || echo "FAILURE to link $source"
done

if [ -e $HOME/.profile ]; then
	mv $HOME/.profile $backup_dir/.profile
fi
if [ -e $HOME/.bashrc ]; then
	mv $HOME/.bashrc $backup_dir/.bashrc
fi

# vim: noet
