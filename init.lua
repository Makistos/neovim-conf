--[[ init.lua ]]

-- LEADER
vim.g.mapleader = ","
vim.g.localleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- IMPORTS
require ('vars')
require ('opts')
require ('keys')
require ('plug')

-- PLUGINS
require('nvim-autopairs').setup{}
if not vim.g.vscode then
require('nvim-tree').setup()
require('lualine').setup {
    options = {
        theme = 'wombat_lush'
    }
}
-- require('vim-gitgutter').setup {
-- }

end
