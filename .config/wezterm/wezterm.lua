local wezterm = require 'wezterm'
local platform = require('utils.platform')()

local config = wezterm.config_builder()

if platform.is_win then
  config.default_prog = { "nyagos.exe" }
elseif platform.is_linux then
  config.default_prog = { "bash" }
end

-- +-----------------+
-- | Font            |
-- +-----------------+
-- font (https://wezfurlong.org/wezterm/config/fonts.html)
-- Morelarspace {Argon,Neon,Xenon,Krypton}
config.font = wezterm.font_with_fallback({
    { family = "Moralerspace Argon HWNF", weight = "Regular" },
    { family = "PlemolJP Console NF", weight = "Regular" },
    "Consolas",
  })
if platform.is_win then
  config.font_size = 12.0
elseif platform.is_linux then
  config.font_size = 16.0
end


-- +-----------------+
-- | Appearance      |
-- +-----------------+
config.color_scheme = "OneHalfDark"
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.window_background_opacity = 1.00
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

treat_east_asian_ambigrous_width_as_wiide = false

if platform.is_linux then
  config.integrated_title_button_style = "Gnome"
elseif platform.is_win then
  config.integrated_title_button_style = "Windows"
end

-- +-----------------+
-- | Domains         |
-- +-----------------+
-- config.wsl_domains = {
--   {
--     name = "Ubuntu",
--     distribution = "Ubuntu",
--   }
-- }

-- +-----------------+
-- | Launch          |
-- +-----------------+
-- launch (https://wezfurlong.org/wezterm/config/launch.html)
local nerdfonts = wezterm.nerdfonts
if platform.is_win then
  config.launch_menu = {
    {
      label = (nerdfonts.cod_terminal_cmd .. " ") .. "Command Prompt",
      args = { "cmd.exe" },
    },
    {
      label = (nerdfonts.oct_terminal .. " ") .. "NYAGOS",
      args = { "nyagos.exe" },
    },
    {
      label = (nerdfonts.linux_ubuntu .. " ") .. "Ubuntu",
      args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
    },
    {
      label = (nerdfonts.linux_ubuntu .. " ") .. "Ubuntu-22.04",
      args = { "wsl.exe", "-d", "Ubuntu-22.04", "--cd", "~" },
    },
    {
      label = (nerdfonts.linux_ubuntu .. " ") .. "ArchLinux",
      args = { "wsl.exe", "-d", "ArchLinux", "--cd", "~" },
    }
  }
elseif platform.is_linux then
  config.launch_menu = {
    {
      label = "bash",
      args = { "/bin/bash", "-himBHs" },
    }
  }
end

for k,v in pairs(require('key_bindings')) do
  config[k] = v
end

for k,v in pairs(require('mouse_bindings')) do
  config[k] = v
end

return config
