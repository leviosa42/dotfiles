#!/usr/bin/env bash
set -ue

echo "=== START install.sh ==="

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

mkdir ~/.backup
mv ~/.bashrc ~/.backup
mv ~/.vim ~/.backup
mv ~/.vimrc ~/.backup

ln -sfnv ${script_dir}/.config ~/.config
ln -sfnv ${script_dir}/.config/bash/dot.bashrc ~/.bashrc
ln -sfnv ${script_dir}/.config/vim/dot.vimrc ~/.vimrc

source ~/.bashrc

echo "=== END install.sh ==="