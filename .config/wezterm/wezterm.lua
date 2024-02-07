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
config.font = wezterm.font_with_fallback({
    { family = "PlemolJP Console NF", weight = "Regular" },
    "Consolas",
  })
config.font_size = 12.0


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
config.window_background_opacity = 0.95

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
config.launch_menu = {
  -- windows
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

for k,v in pairs(require('key_bindings')) do
  config[k] = v
end

for k,v in pairs(require('mouse_bindings')) do
  config[k] = v
end

return config
