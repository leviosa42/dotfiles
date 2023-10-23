$dir_home = $env:USERPROFILE
$dir_dotfiles = Join-Path $dir_home ".dotfiles"
$url_dotfiles = "https://github.com/leviosa42/dotfiles.git"


# ====================
# Utilities
# ====================
function Write-Log([string]$message) {
    Write-Host "[LOG] $message" -ForegroundColor Gray
}
function Write-Info([string]$message) {
    Write-Host "[INFO] $message" -ForegroundColor Cyan
}

function Write-Success([string]$message) {
    Write-Host "[SUCCSS] $message" -ForegroundColor Green
}

function Write-Warning([string]$message) {
    Write-Host "[WARN] $message" -ForegroundColor Yellow
}

function Write-Error([string]$message) {
    Write-Host "[ERR] $message" -ForegroundColor Red
}


function New-Symlink([string]$target, [string]$link) {
    if (Test-Path $link) {
        Write-Warning "Remove-Item $link"
        Remove-Item $link -Recurse
    }
    Write-Log "New-Symlink: $link -> $target"
    New-Item -ItemType SymbolicLink -Path $link -Value $target > $null
}

function Set-EnvironmentVariable([string]$name, [string]$value) {
    Write-Log "Set-EnvironmentVariable: $name  $value"
    # if([Environment]::GetEnvironmentVariable($name, "User") -eq $value) {
    #     return
    # } else {
    #     [Environment]::SetEnvironmentVariable($name, $value, "User")
    # }
    [Environment]::SetEnvironmentVariable($name, $value, "User")
    Invoke-Expression "`$env:${name} = `"$value`""
}

function New-Directory([string]$path) {
    if (!(Test-Path $path)) {
        Write-Log "New-Directory: $path"
        New-Item -ItemType Directory -Path $path > $null
    }
}

function Install-WinGetPackage([string]$package) {
    Write-Log "Install-WinGetPackage: $package"
    winget install -e --no-upgrade --accept-source-agreements $package
}

function Install-ScoopPackage([string]$package) {
    Write-Log "Install-ScoopPackage: $package"
    scoop install $package
}

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) {
    Write-Error "Please run this script as Administrator"
    Pause
    exit
}

# check winget is installed
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Info "winget is installed"
    # Microsoft.PowerToys
    Install-WinGetPackage("Microsoft.PowerToys")
    # Microsoft.PowerShell
    Install-WinGetPackage("Microsoft.PowerShell")
    # Microsoft.Office
    # [NOTE]: maybe it is recommended to install from Microsoft Store...
    # Install-WinGetPackage("Microsoft.Office")
    # Microsoft.Edge
    Install-WinGetPackage("Microsoft.Edge")
    # Microsoft.WindowsTerminal
    Install-WinGetPackage("Microsoft.WindowsTerminal")
    # Microsoft.VisualStudioCode
    Install-WinGetPackage("Microsoft.VisualStudioCode")
    # Git.Git
    Install-WinGetPackage("Git.Git")
    # Git.GitHub
    Install-WinGetPackage("Git.GitHub")
    # Oracle.VirtualBox
    Install-WinGetPackage("Oracle.VirtualBox")
    # Oracle.MySQL
    Install-WinGetPackage("Oracle.MySQL")
    # eza-community.eza
    Install-WinGetPackage("eza-community.eza")
    # FastCopy.FastCopy
    Install-WinGetPackage("FastCopy.FastCopy")
    # Readdle.Spark
    Install-WinGetPackage("Readdle.Spark")
} else {
    Write-Error "winget is not installed"
    exit
}


# ====================
# Environment Variables
# ====================
# HOME
Set-EnvironmentVariable "HOME" "$dir_home"
# ENV (for busybox's .ashrc)
Set-EnvironmentVariable "ENV" "$dir_home\.ashrc"
# XDG_Base_Directory
Set-EnvironmentVariable "XDG_CONFIG_HOME" "$dir_home\.config"
Set-EnvironmentVariable "XDG_CACHE_HOME" "$dir_home\.cache"
Set-EnvironmentVariable "XDG_DATA_HOME" "$dir_home\.local\share"
New-Directory "$dir_home\.local\share"
Set-EnvironmentVariable "XDG_STATE_HOME" "$dir_home\.local\state"
New-Directory "$dir_home\.local\state"
# vim
Set-EnvironmentVariable "VIMINIT"  "if !has('nvim') | so `$XDG_CONFIG_HOME\vim\dot.vimrc | else | so `$XDG_CONFIG_HOME\nvim\init.vim | endif"
# ipython/jupiter
Set-EnvironmentVariable "IPYTHONDIR"  "$env:XDG_CONFIG_HOME\jupyter"
Set-EnvironmentVariable "JUPYTER_CONFIG_DIR"  "$env:XDG_CONFIG_HOME\jupyter"
# go
Set-EnvironmentVariable "GOPATH"  "$env:XDG_DATA_HOME\go"
# rust#cargo
Set-EnvironmentVariable "CARGO_HOME"  "$env:XDG_DATA_HOME\cargo"
# rust#rustup
Set-EnvironmentVariable "RUSTUP_HOME"  "$env:XDG_DATA_HOME\rustup"


# ====================
# dotfiles
# ====================
# check dotfiles is cloned
if (!(Test-Path $dir_dotfiles)) {
    Write-Info "git clone $url_dotfiles $dir_dotfiles"
    git clone $url_dotfiles $dir_dotfiles
}
# dotfiles\.config -> %HOME%\.config
New-Symlink "$dir_dotfiles\.config" "$dir_home\.config"
# dotfiles\.config\vim\dot.vimrc -> %HOME%\.vimrc
# New-Symlink "$dir_dotfiles\.config\vim\dot.vimrc" "$dir_home\.vimrc"
# dotfiles\.config\nyagos\dot.nyagos -> %HOME%\.nyagos
New-Symlink "$dir_dotfiles\.config\nyagos\dot.nyagos" "$dir_home\.nyagos"
# dotfiles\.config\wt\settings.json -> %HOME%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
New-Symlink "$dir_dotfiles\.config\wt\settings.json" "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
# ====================
# scoop
# ====================
# check scoop is installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    # bootstrap scoop
    Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
}


# ====================
# scoop
# ====================
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
