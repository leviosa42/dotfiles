# makefile for Ubuntu dotfiles

.DEFAULT_GOAL := help
.PHONY := help init link install

ENV_XDG := .config/bash/env.xdg.sh

## help: Show this help message
help:
	@grep -E "^## [a-zA-Z_-]+: .*$$" $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = "^##|: "}; {printf "\033[36m%-30s\033[0m %s\n", $$2, $$3}'

all: init link install

## init: Initialize dotfiles
init: init_bash

## link: Link dotfiles
link:
	bash scripts/link.sh
	exec $$SHELL -l

## install: Install all packages
install: install_packages install_bat install_eza install_nvim install_nodejs install_rustup

## init_bash: Initialize bash. Support for XDG Base Directory
init_bash:
	# Support for XDG Base Directory
	# see: https://wiki.archlinux.jp/index.php/XDG_Base_Directory
	sudo cp /etc/bash.bashrc /etc/bash.bashrc.bak
	echo "source \$${XDG_CONFIG_HOME:-\$$HOME/.config}/bash/dot.bashrc" | sudo tee -a /etc/bash.bashrc

## install_packages: Install packages
install_packages:
	sudo apt-get update
	sudo apt-get install -y \
		git gh wget curl nano vim ca-certificates build-essential gpg sudo

## install_bat: Install sharkdp/bat
install_bat:
	. $(ENV_XDG) && bash scripts/install_bat.sh

## install_eza: Install eza-community/eza
install_eza:
	. $(ENV_XDG) && bash scripts/install_eza.sh

## install_nvim: Install neovim/neovim
install_nvim:
	. $(ENV_XDG) && bash scripts/install_nvim.sh

install_nodejs:
	. $(ENV_XDG) && bash scripts/install_nodejs.sh

install_rustup:
	. $(ENV_XDG) && bash scripts/install_rustup.sh
