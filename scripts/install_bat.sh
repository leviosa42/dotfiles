#!/bin/bash

set -euo pipefail

if command -v bat &> /dev/null; then
  echo "bat is already installed"
  exit 0
fi

# see: https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt
sudo apt-get update
sudo apt-get install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

