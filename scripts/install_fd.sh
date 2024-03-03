#!/bin/bash

sudo apt update
sudo apt install -y fd-find
ln -s /usr/bin/fdfind ~/.local/bin/fd
