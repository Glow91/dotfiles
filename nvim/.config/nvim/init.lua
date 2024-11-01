
-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('core.options') -- Load general options

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = 'nord'

local plugins = {
  require('plugins.nord'),
  require('plugins.nvim-tree')
}

local options = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "nord" },
	},
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrw",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
	},
	change_detection = {
		-- TODO: set to false later
		notify = true,
	},
}

require('lazy').setup(plugins, options)