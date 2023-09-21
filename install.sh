#!/usr/bin/env bash
set -ue

echo "=== START install.sh ==="

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

sudo rm -rf ~/.bashrc
sudo rm -rf ~/.vim
sudo rm -rf ~/.vimrc

ln -sfnv ${script_dir}/.config ~/.config
ln -sfnv ${script_dir}/.config/bash/dot.bashrc ~/.bashrc
ln -sfnv ${script_dir}/.config/vim/dot.vimrc ~/.vimrc

source ~/.bashrc

echo "=== END install.sh ==="