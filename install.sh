#!/bin/bash

set -euo pipefail

: "Pre configuration" && {
  # dotfiles
  DOTFILES_DIR=$HOME/.dotfiles
  DOTFILES_GIT_URL='https://github.com/leviosa42/dotfiles.git'
  DOTFILES_BACKUP_DIR=$HOME/.dotfiles_backup
  DOTFILES_INSTALL_LOG=/tmp/dotfiles_install.log
  # 
  PACKAGE_MANAGER=""
  # XDG Base Directory Specification
  XDG_CONFIG_HOME=$HOME/.config
  XDG_DATA_HOME=$HOME/.local/share
  XDG_CACHE_HOME=$HOME/.cache
  XDG_STATE_HOME=$HOME/.local/state
  # XDG_RUNTIME_DIR=/run/user/$UID
}

: "Utility functions" && {
  function __log() {
    # Usage: __log <group> <message>
    # Example: __log "install" "Installing dotfiles"
    # Shown as [install] Installing dotfiles
    local group=$1
    local message=$2
    local out="[$group] $message"
    echo -e $out
    echo -e $out >> $DOTFILES_INSTALL_LOG
  }
  function __check_command() {
    # Return 0 if command exists
    # Usage: __check_command <command>
    local command=$1
    if command -v $command &> /dev/null; then
      return 0
    else
      return 1
    fi
  }
  function __sure_command() {
    # Usage: __sure_command <command>
    # Example: __sure_command "git"
    # Shown as [install] Checking for git
    local command=$1
    __log "install" "Checking for $command"
    if ! command -v $command &> /dev/null; then
      __log "install" "Command not found: $command"
      __log "install" "Installing $command"
      sudo apt install -y $command
    fi
  }
}

function main() {
  # Usage
  # main <options>
  : "package manager" && {
    # __log "package-manager" "Checking for package manager"
    # if [[ __check_command "apt" ]]; then
    #   PACKAGE_MANAGER="apt"
    #   __log "package-manager" "PACKAGE_MANAGER: $PACKAGE_MANAGER"
    # else
    #   __log "package-manager" "Package manager excluding apt is not supported yet..."
    #   exit 1
    # fi
    # sed archive.ubuntu.com to ftp.udx.icscoe.jp
    sudo sed -i.bak 's/archive.ubuntu.com/ftp.udx.icscoe.jp/g' /etc/apt/sources.list
    __log "package-manager" "sudo apt update"
    sudo apt update
    __log "package-manager" "sudo apt upgrade -y"
    sudo apt upgrade -y
  }
  : "XDG Base Directory Specification" && {
    if [[ ! -d $XDG_CONFIG_HOME ]]; then
      __log "xdg" "Creating $XDG_CONFIG_HOME"
      mkdir -p $XDG_CONFIG_HOME
    fi
    if [[ ! -d $XDG_DATA_HOME ]]; then
      __log "xdg" "Creating $XDG_DATA_HOME"
      mkdir -p $XDG_DATA_HOME
    fi
    if [[ ! -d $XDG_CACHE_HOME ]]; then
      __log "xdg" "Creating $XDG_CACHE_HOME"
      mkdir -p $XDG_CACHE_HOME
    fi
    if [[ ! -d $XDG_STATE_HOME ]]; then
      __log "xdg" "Creating $XDG_STATE_HOME"
      mkdir -p $XDG_STATE_HOME
    fi
    # if [[ ! -d $XDG_RUNTIME_DIR ]]; then
    #   __log "xdg" "Creating $XDG_RUNTIME_DIR"
    #   mkdir -p $XDG_RUNTIME_DIR
    # fi
  }
  : "dotfiles" && {
    : "dotfiles-install" && {
      __log "install" "Checking for git"
      __sure_command "git"
      if [[ ! -d $DOTFILES_DIR ]]; then
        __log "install" "Cloning dotfiles"
        git clone $DOTFILES_GIT_URL $DOTFILES_DIR
      else
        __log "install" "Updating dotfiles"
        git -C $DOTFILES_DIR pull
      fi
    }
    : "dotfiles-backup" && {
      if [[ ! -d $DOTFILES_BACKUP_DIR ]]; then
        __log "backup" "Creating backup directory"
        mkdir -p $DOTFILES_BACKUP_DIR
      fi
      : "bash" && {
        if [[ ! -d $DOTFILES_BACKUP_DIR/bash ]]; then
          __log "backup" "Creating backup directory for bash"
          mkdir -p $DOTFILES_BACKUP_DIR/bash
        fi
        if [[ -f $HOME/.bashrc ]]; then
          __log "backup" "Backing up .bashrc"
          mv $HOME/.bashrc $DOTFILES_BACKUP_DIR
        fi
        if [[ -f $HOME/.bash_profile ]]; then
          __log "backup" "Backing up .bash_profile"
          mv $HOME/.bash_profile $DOTFILES_BACKUP_DIR
        fi
        if [[ -f $HOME/.bash_logout ]]; then
          __log "backup" "Backing up .bash_logout"
          mv $HOME/.bash_logout $DOTFILES_BACKUP_DIR
        fi
        if [[ -f $HOME/.profile ]]; then
          __log "backup" "Backing up .profile"
          mv $HOME/.profile $DOTFILES_BACKUP_DIR
        fi
      }
      : "vim" && {
        if [[ ! -d $DOTFILES_BACKUP_DIR/vim ]]; then
          __log "backup" "Creating backup directory for vim"
          mkdir -p $DOTFILES_BACKUP_DIR/vim
        fi
        if [[ -f $HOME/.vimrc ]]; then
          __log "backup" "Backing up .vimrc"
          mv $HOME/.vimrc $DOTFILES_BACKUP_DIR/vim
        fi
        if [[ -d $HOME/.vim ]]; then
          __log "backup" "Backing up .vim"
          mv $HOME/.vim $DOTFILES_BACKUP_DIR/vim/.vim
        fi
      }
      : "nvim" && {
        if [[ ! -d $DOTFILES_BACKUP_DIR/nvim ]]; then
          __log "backup" "Creating backup directory for nvim"
          mkdir -p $DOTFILES_BACKUP_DIR/nvim
        fi
        if [[ -f $HOME/.config/nvim/init.vim ]]; then
          __log "backup" "Backing up init.vim"
          mv $HOME/.config/nvim/init.vim $DOTFILES_BACKUP_DIR/nvim
        fi
      }
    }
    : "dotfiles-link" && {
      __log "link" "Linking dotfiles"
      # bash
      __log "link" "ln -s $DOTFILES_DIR/.config/bash/dot.bashrc $HOME/.bashrc"
      ln -snv $DOTFILES_DIR/.config/bash/dot.bashrc $HOME/.bashrc
      # vim
      ln -snv $DOTFILES_DIR/.config/vim/ $XDG_CONFIG_HOME/vim
      # nvim
      __log "link" "ln -s $DOTFILES_DIR/.config/nvim/ $XDG_CONFIG_HOME/nvim"
      ln -snv $DOTFILES_DIR/.config/nvim/ $XDG_CONFIG_HOME/nvim
      # alacritty
      __log "link" "ln -s $DOTFILES_DIR/.config/alacritty/ $XDG_CONFIG_HOME/alacritty"
      ln -snv $DOTFILES_DIR/.config/alacritty/ $XDG_CONFIG_HOME/alacritty
    }
  }
}

main
# vim: set ft=sh et ts=2 sw=0 sts=-1 fdm=marker fmr={,}:

