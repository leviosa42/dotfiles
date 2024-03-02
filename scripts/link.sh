#!/bin/bash

set -euo pipefail

HOME=${HOME:~}
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:$HOME/.config}
DOTFILES_ROOTDIR=${DOTFILES_ROOTDIR:$HOME/.dotfiles}

linked_source=(
  .config/alacritty/
  .config/ash/
  .config/bash/
  .config/git/
  # .config/nyagos/
  .config/sh/
  .config/vim/
  .config/wezterm/
  # .config/wt/
)

backup_dir=$XDG_CACHE_HOME/dotfiles/$(date "+%Y%m%d%H%M%S")
mkdir -p $backup_dir

for target in "${linked_sources[@]}"; do
  [ -e $XDG_CONFIG_HOME/$target ] && mv $XDG_CONFIG_HOME/$target $backup_dir
  ln -sfnv $DOTFILES_ROOTDIR/$target $XDG_CONFIG_HOME/$target
done

# vim: noet
