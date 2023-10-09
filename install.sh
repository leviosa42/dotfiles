#!/usr/bin/env bash
set -ue

echo "=== START install.sh ==="

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

mkdir -p ~/.backup
if [ -e ~/.bashrc ]; then
  mv ~/.bashrc ~/.backup
fi
if [ -e ~/.vim ]; then
  mv ~/.vim ~/.backup
fi
if [ -e ~/.vimrc ]; then
  mv ~/.vimrc ~/.backup
fi

ln -sfnv ${script_dir}/.config ~/.config
ln -sfnv ${script_dir}/.config/bash/dot.bashrc ~/.bashrc
ln -sfnv ${script_dir}/.config/vim/dot.vimrc ~/.vimrc

source ~/.bashrc

echo "=== END install.sh ==="
