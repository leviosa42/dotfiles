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
config.window_background_opacity = 0.90
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

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
if platform.is_win then
  config.launch_menu = {
    {
      label = "Command Prompt",
      args = { "cmd.exe" },
    },
    {
      label = "NYAGOS",
      args = { "nyagos.exe" },
    },
    {
      label = "Ubuntu",
      args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
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
