--[[ init.lua ]]

-- LEADER
vim.g.mapleader = ","
vim.g.localleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- IMPORTS
require ('vars')
require ('plug')
require ('keys')
require ('opts')

-- PLUGINS
require('nvim-autopairs').setup{}
if not vim.g.vscode then
require('nvim-tree').setup()
require('lualine').setup {
    options = {
        theme = 'auto'
    }
}
-- require('vim-gitgutter').setup {
-- }

end

          opt = false

if vim.g.vscode then
    -- VSCode extension
else
    -- Ordinary Neovim
end
