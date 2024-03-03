# 💻 dotfiles
![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/leviosa42/dotfiles/docker-publish.yml?style=for-the-badge&logo=docker)

## Usage

## Ubuntu

```sh
bash <(curl -sL https://raw.githubusercontent.com/leviosa42/dotfiles/main/install.sh)
```

#### Windows

not yet

## Install

### Windows

1. Install [winget].
2. Open PowerShell as **Admin** and run below script.

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm https://raw.githubusercontent.com/leviosa42/dotfiles/main/install.ps1 | iex
```

<!--
### WSL2

### Import from ghcr.io

```cmd
docker container export $(docker container create ghcr.io/leviosa42/dotfiles) -o %USERPROFILE%\wsl-dotfiles.tar
wsl --import dotfiles %USERPROFILE%\wsl-dotfiles %USERPROFILE%\wsl-dotfiles.tar --version 2
```
-->

[winget]: https://apps.microsoft.com/detail/9NBLGGH4NNS1?hl=ja-jp&gl=JP
