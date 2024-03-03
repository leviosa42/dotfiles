#!bin/bash

set -euo pipefail

if command -v eza &> /dev/null; then
  echo "eza is already installed"
  exit 0
fi

# see: https://github.com/eza-community/eza/blob/main/INSTALL.md#debian-and-ubuntu
if [ ! $(command -v gpg &> /dev/null) ]; then \
  sudo apt-get update; \
  sudo apt install -y gpg; \
fi
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --yes -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

