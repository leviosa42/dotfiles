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

-- golang
-- GOPATH
nyagos.env.GOPATH = nyagos.pathjoin(nyagos.env.XDG_DATA_HOME, "go")
mkdirp(nyagos.env.GOPATH)
-- GO111MODULE
nyagos.env.GO111MODULE = "on"
-- GOBIN
nyagos.env.GOBIN = nyagos.pathjoin(nyagos.env.XDG_DATA_HOME, "go", "bin")
mkdirp(nyagos.env.GOBIN)
nyagos.envadd("PATH", nyagos.env.GOBIN)
-- GOCACHE
nyagos.env.GOCACHE = nyagos.pathjoin(nyagos.env.XDG_CACHE_HOME, "go-build")
mkdirp(nyagos.env.GOCACHE)
-- GOMODCACHE
nyagos.env.GOMODCACHE = nyagos.pathjoin(nyagos.env.XDG_CACHE_HOME, "go", "mod")
mkdirp(nyagos.env.GOMODCACHE)

-- rust/cargo
nyagos.env.CARGO_HOME = nyagos.pathjoin(nyagos.env.XDG_DATA_HOME, "cargo")
mkdirp(nyagos.env.CARGO_HOME)
nyagos.envadd("PATH", nyagos.pathjoin(nyagos.env.CARGO_HOME, "bin"))

-- scoop (end of PATH)
nyagos.envdel("PATH", nyagos.pathjoin("scoop", "shims"))
nyagos.envadd("PATH", nyagos.pathjoin(nyagos.env.HOME, "scoop", "shims"))

-- deno
nyagos.envadd("PATH", nyagos.pathjoin(nyagos.env.HOME, ".deno", "bin"))
