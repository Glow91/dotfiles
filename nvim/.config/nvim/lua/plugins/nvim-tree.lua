local keymap = vim.keymap
local opts = {noremap = true, silent = true}

keymap.set('n', '<leader>ex', ':NvimTreeToggle<CR>', opts)
keymap.set('n', '<leader>ef', ':NvimTreeFindFileToggle<CR>', opts)
keymap.set('n', '<leader>ff', ':NvimTreeFindFile<CR>', opts)
keymap.set('n', '<leader>fx', ':NvimTreeFocus<CR>', opts)

keymap.set('n', '<leader>fs+', ':NvimTreeResize +20<CR>', opts)
keymap.set('n', '<leader>fs-', ':NvimTreeResize -20<CR>', opts)
keymap.set('n', '<leader>fsb', ':NvimTreeResize 40<CR>', opts)

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
        vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=None]])
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,                                                       
            },
        })
    end,
}