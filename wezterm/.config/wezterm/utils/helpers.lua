local wezterm = require("wezterm")
local M = {}

local appearance = wezterm.gui.get_appearance()

M.is_dark = function()
	return appearance:find("Dark")
end

M.get_random_entry = function(tbl)
	local keys = {}
	for key, _ in ipairs(tbl) do
		table.insert(keys, key)
	end
	local randomKey = keys[math.random(1, #keys)]
	return tbl[randomKey]
end

M.getHomePath = function()
  return os.getenv("HOME") or os.getenv("USERPROFILE")
end

M.get_os = function()
  local target = wezterm.target_triple
  if target:find("windows") then
    return "Windows"
  elseif target:find("linux") then
    return "Linux"
  elseif target:find("darwin") then
    return "macOS"
  else
    return "Unknown OS"
  end
end

return M