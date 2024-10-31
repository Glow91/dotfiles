-- Pull in the wezterm API
local wezterm = require('wezterm')
local M = {}

M.apply_to_config = function(config)
    config.color_scheme = 'Selenized Dark (Gogh)'
    config.font = wezterm.font 'JetBrainsMono Nerd Font'
    config.font_size = 12
end

return M 