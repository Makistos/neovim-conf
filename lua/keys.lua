--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

--[[ keys-common.lua ]]
local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
map("i", "jk", "<ESC>", {})

map('n', '<C-s>', ":w<CR>", {})

-- Copy selected lines in visual mode up/down
map('v', "J", ":m '>+1<CR>gv=gv", {})
map('v', "K", ":m '<-2<CR>gv=gv", {})

-- When pasting over a word, don't remove original from buffer
map('x', '<leader>p', [["_dP"]], {})

if not vim.g.vscode then
    map('n', '<F5>', ":NvimTreeToggle<CR>", {silent = true})
end
