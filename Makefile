# makefile for Ubuntu dotfiles

.DEFAULT_GOAL := help
.PHONY := help init link install

PWD := $(shell pwd)
USER := $(shell whoami)
UID := $(shell id -u)
SOURCE_ENV_XDG := set -a && . .config/bash/env.xdg.sh && set +a

## help: Show this help message
help:
	@grep -E "^## [a-zA-Z_-]+: .*$$" $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = "^##|: "}; {printf "\033[36m%-30s\033[0m %s\n", $$2, $$3}' \
		| sort

## dev: Dev mode: run docker with mounted dotfiles
dev: dev_build dev_run

## dev_build: Build docker image for dev mode
dev_build:
	docker buildx build \
		--tag dotfiles-dev \
		--file Dockerfile.dev \
		--build-arg USER_NAME=$(USER) \
		--build-arg USER_UID=$(UID) \
		.

## dev_run: Run docker container for dev mode
dev_run:
	docker container run \
		--rm \
		-it \
		--name dotfiles-dev \
		-v $(PWD):/home/$(USER)/.dotfiles \
		-w /home/$(USER)/.dotfiles \
		-u $(USER) \
		dotfiles-dev

## prod: Production mode: run docker with mounted dotfiles
prod: prod_build prod_run

## prod_build: Build docker image for prod mode
prod_build:
	docker buildx build \
		--tag dotfiles-prod \
		--file Dockerfile \
		.

## prod_run: Run docker container for prod mode
prod_run:
	docker container run \
		--rm \
		-it \
		--name dotfiles-prod \
		dotfiles-prod

## all: make init link install
all: init link install

## init: Initialize dotfiles
init: init_bash

## link: Link dotfiles
link:
	bash scripts/link.sh

## install: Install all packages
install: install_packages install_bat install_eza install_nvim install_nodejs install_rustup

## init_mirror_jp: configures the mirror for apt
init_mirror_jp:
	echo -e "\033[33m[make init_mirror_jp]\033[0m"
	# see: https://raw.githubusercontent.com/leviosa42/dotfiles/main/install.sh
	sudo sed -i.bak -r \
		's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' \
		/etc/apt/sources.list

## init_bash: Initialize bash. Support for XDG Base Directory
init_bash:
	echo -e "\033[33m[make init_bash]\033[0m"
	# Support for XDG Base Directory
	# see: https://wiki.archlinux.jp/index.php/XDG_Base_Directory
	sudo cp /etc/bash.bashrc /etc/bash.bashrc.bak
	echo "source \$${XDG_CONFIG_HOME:-\$$HOME/.config}/bash/dot.bashrc" | sudo tee -a /etc/bash.bashrc

## install_packages: Install packages
install_packages:
	echo -e "\033[33m[make install_packages]\033[0m"
	sudo apt-get update
	sudo apt-get install -y \
		git gh wget curl nano vim ca-certificates build-essential gpg sudo ripgrep

## install_bat: Install sharkdp/bat
install_bat:
	echo -e "\033[33m[make install_bat]\033[0m"
	$(SOURCE_ENV_XDG) && bash scripts/install_bat.sh

## install_eza: Install eza-community/eza
install_eza:
	echo -e "\033[33m[make install_eza]\033[0m"
	$(SOURCE_ENV_XDG) && bash scripts/install_eza.sh

## install_nvim: Install neovim/neovim
install_nvim:
	echo -e "\033[33m[make install_nvim]\033[0m"
	$(SOURCE_ENV_XDG) && bash scripts/install_nvim.sh

## install_nodejs: Install Node.js
install_nodejs:
	echo -e "\033[33m[make install_nodejs]\033[0m"
	$(SOURCE_ENV_XDG) && bash scripts/install_nodejs.sh

## install_rustup: Install rustup
install_rustup:
	echo -e "\033[33m[make install_rustup]\033[0m"
	$(SOURCE_ENV_XDG) && bash scripts/install_rustup.sh

## install_wslu: Install wslu
install_wslu:
	$(SOURCE_ENV_XDG) && bash scripts/install_wslu.sh
