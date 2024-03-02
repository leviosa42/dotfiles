#!/bin/bash

set -euo pipefail

# apt mirror
# see: https://zenn.dev/ciffelia/articles/c394962a8f188a
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list
sudo apt update && sudo apt upgrade -y

# Install dependencies to clone and run dotfiles/Makefile
sudo apt install -y git make

git clone https://github.com/leviosa42/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

make all

