# 💻 dotfiles

## Usage

```sh
docker container run --rm -it ghcr.io/leviosa42/dotfiles
```

## Install

### Windows

1. Install [winget].
2. Open PowerShell as **Admin** and run below script.

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm https://raw.githubusercontent.com/leviosa42/dotfiles/main/install.ps1 | iex
```

### WSL2

### Import from ghcr.io

```cmd
docker container export $(docker container create ghcr.io/leviosa42/dotfiles:main) -o %USERPROFILE%\wsl-dotfiles.tar
wsl --import dotfiles %USERPROFILE%\wsl-dotfiles %USERPROFILE%\wsl-dotfiles.tar --version 2
```

```sh
sudo apt update && sudo apt upgrade -y
sudo apt install git -y
git clone https://github.com/leviosa42/dotfiles.git ~/.dotfiles
bash ~/.dotfiles/install.sh
```

[winget]: https://apps.microsoft.com/detail/9NBLGGH4NNS1?hl=ja-jp&gl=JP