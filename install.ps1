$dir_home = $env:USERPROFILE
$dir_dotfiles = Join-Path $dir_home ".dotfiles"

# ====================New-Symlink
# Utilities
# ====================
function New-Symlink([string]$target, [string]$link) {
    if (Test-Path $link) {
        Remove-Item $link
    }
    New-Item -ItemType SymbolicLink -Path $link -Value $target > $null
}

function Install-WinGetPackage([string]$package) {
    winget install -e --no-upgrade --accept-source-agreements $package 
}

function Install-ScoopPackage([string]$package) {
    scoop install $package
}

# check winget is installed
if (Get-Command winget -ErrorAction SilentlyContinue) {
    # Microsoft.PowerToys
    Install-WinGetPackage("Microsoft.PowerToys")
    # Microsoft.PowerShell
    Install-WinGetPackage("Microsoft.PowerShell")
    # Microsoft.WindowsTerminal
    Install-WinGetPackage("Microsoft.WindowsTerminal")
    # Microsoft.VisualStudioCode
    Install-WinGetPackage("Microsoft.VisualStudioCode")
    # Git.Git
    Install-WinGetPackage("Git.Git")
    # Git.GitHub
    Install-WinGetPackage("Git.GitHub")
} else {
    Write-Host "winget is not installed"
    exit
}

# ====================
# dotfiles
# ====================
# check dotfiles is cloned
if (!(Test-Path $dir_dotfiles)) {
    Write-Host "Cloning dotfiles..."
    git clone https://github.com/leviosa42/dotfiles.git $dir_dotfiles
}
# dotfiles\.config -> %HOME%\.config
New-Symlink "$dir_dotfiles\.config" "$dir_home\.config"
# dotfiles\.config\vim\dot.vimrc -> %HOME%\.vimrc
New-Symlink "$dir_dotfiles\.config\vim\dot.vimrc" "$dir_home\.vimrc"
# dotfiles\.config\nyagos\dot.nyagos -> %HOME%\.nyagos
New-Symlink "$dir_dotfiles\.config\nyagos\dot.nyagos" "$dir_home\.nyagos"
# ====================
# scoop
# ====================
# check scoop is installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    # bootstrap scoop
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

# 7zip
Install-ScoopPackage("7zip")
# aria2
Install-ScoopPackage("aria2")
# vim
Install-ScoopPackage("vim")
# bat
Install-ScoopPackage("bat")
# nyagos
Install-ScoopPackage("nyagos")
