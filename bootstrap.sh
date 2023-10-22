#!/usr/bin/sh

sudo apt update && sudo apt upgrade -y

sudo apt install git gh -y

cd $HOME
git clone https://github.com/leviosa42/dotfiles.git ~/.dotfiles

bash ./.dotfiles/install.sh
