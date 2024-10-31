-- Pull in the wezterm API
local wezterm = require('wezterm')
local act = wezterm.action
local M = {}

M.apply_to_config = function(config)
    config.keys = {
        { key = 'y', mods = 'CMD', action = act.ActivateTabRelative(-1) },
        { key = 'c', mods = 'CMD', action = act.ActivateTabRelative(1) },
      }
end

return M