-- env.lua
local mkdirp = require("util.mkdirp")

local home = nyagos.getenv("HOME") or nyagos.getenv("USERPROFILE")

-- HOME
nyagos.env.HOME = home

-- XDG Base Directory Specification
nyagos.env.XDG_CONFIG_HOME = nyagos.getenv("XDG_CONFIG_HOME") or (home .. "\\.config")
nyagos.env.XDG_CACHE_HOME = nyagos.getenv("XDG_CACHE_HOME") or (home .. "\\.cache")
nyagos.env.XDG_DATA_HOME = nyagos.getenv("XDG_DATA_HOME") or (home .. "\\.local\\share")
nyagos.env.XDG_STATE_HOME = nyagos.getenv("XDG_STATE_HOME") or (home .. "\\.local\\state")

-- Create XDG Base Directories
mkdirp(nyagos.env.XDG_CONFIG_HOME)
mkdirp(nyagos.env.XDG_CACHE_HOME)
mkdirp(nyagos.env.XDG_DATA_HOME)
mkdirp(nyagos.env.XDG_STATE_HOME)

-- Enviroment Variable
nyagos.env.SHELL = (string.gsub(nyagos.exe, '\\', '/'))
nyagos.env.EDITOR = nyagos.which("nvim")
