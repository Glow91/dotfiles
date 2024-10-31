-- Pull in the wezterm API
local wezterm = require('wezterm')
local b = require('utils/background')
local s = require('utils/styling')
local t = require('utils/tabbar')
local k = require('utils/keys')


-- This will hold the configuration.
local config = wezterm.config_builder()

-- Apply font and color scheme
s.apply_to_config(config)
-- Apply background gradient and opacity
b.apply_to_config(config)
-- Apply tabbar styles and right tab bar widgets
t.apply_to_config(config)

k.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
