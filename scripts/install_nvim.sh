#/bin/bash

set -euo pipefail

if command -v nvim &> /dev/null; then
  echo "nvim is already installed"
  exit 0
fi

# see: https://github.com/neovim/neovim/blob/master/INSTALL.md#appimage-universal-linux-package
mkdir /tmp/install-nvim && cd /tmp/install-nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
