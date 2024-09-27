local wezterm = require 'wezterm'
local act = wezterm.action

local function set_binding(key, mods, action)
  return { key = key, mods = mods, action = action }
end

-- Use CTRL|SHIFT to avoid conflicts with the default key bindings.
return {
  disable_default_key_bindings = true,
  adjust_window_size_when_changing_font_size = false,
  leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 },
  keys = {
    set_binding("F11", "LEADER", act.ToggleFullScreen),
   
    -- Launch Menu
    set_binding("Space", "LEADER", act.ShowLauncherArgs { flags = "LAUNCH_MENU_ITEMS" }),

    -- Reload Configuration
    set_binding("R", "CTRL|SHIFT", act.ReloadConfiguration),

    -- Copy and Paste
    set_binding("C", "CTRL|SHIFT", act.CopyTo "Clipboard"),
    set_binding("V", "CTRL|SHIFT", act.PasteFrom "Clipboard"),

    -- Increase and Decrease Font Size
    --   on JIS keyboard
    set_binding(";", "CTRL", act.IncreaseFontSize),
    set_binding("-", "CTRL", act.DecreaseFontSize),
    set_binding("0", "CTRL", act.ResetFontSize),

    -- Command Palette
    set_binding("P", "CTRL|SHIFT", act.ActivateCommandPalette),

    -- Launch Menu
    set_binding("Space", "CTRL|SHIFT", act.ShowLauncher),

    -- Move Pane Focus
    --   use vim-like key bindings
    set_binding("h", "LEADER", act.ActivatePaneDirection "Left"),
    set_binding("j", "LEADER", act.ActivatePaneDirection "Down"),
    set_binding("k", "LEADER", act.ActivatePaneDirection "Up"),
    set_binding("l", "LEADER", act.ActivatePaneDirection "Right"),

    -- Split Pane
    -- set_binding("s", "LEADER", act.ActivateKeyTable { name = "split_pane", one_shot = false }),
    set_binding("H", "LEADER", act.SplitPane { direction = "Left" }),
    set_binding("J", "LEADER", act.SplitPane { direction = "Down" }),
    set_binding("K", "LEADER", act.SplitPane { direction = "Up" }),
    set_binding("L", "LEADER", act.SplitPane { direction = "Right" }),

    -- Close Pane
    set_binding("c", "LEADER", act.CloseCurrentPane { confirm = true }),

    -- Open Only Current Pane
    set_binding("o", "LEADER", act.TogglePaneZoomState),

    -- Move Tab
    set_binding("{", "CTRL|SHIFT", act.ActivateTabRelative(-1)),
    set_binding("}", "CTRL|SHIFT", act.ActivateTabRelative(1)),

    -- Close Tab
    set_binding("w", "CTRL|SHIFT", act.CloseCurrentTab { confirm = true }),

  },

  key_tables = {
    -- split_pane = {
    --   { key = "h", action = act.SplitPane { direction = "Left" } },
    --   { key = "j", action = act.SplitPane { direction = "Down" } },
    --   { key = "k", action = act.SplitPane { direction = "Up" } },
    --   { key = "l", action = act.SplitPane { direction = "Right" } },
    -- },
  },
}

