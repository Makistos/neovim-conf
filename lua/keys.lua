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
	map('n', '<F4>', ':Gitsigns toggle_signs<CR>', {silent = true})
    map('n', '<F5>', ":NvimTreeToggle<CR>", {silent = true})
	map('n', '<C-p>', ":Telescope find_files<CR>", {silent = true})

    -- Debugger 
    -- map('n', '<F6>', ":DapContinue<CR>", {silent = true})
    -- map('n', '<F7>', ":DapStepOver<CR>", {silent = true})
    -- map('n', '<F8>', ":DapStepInto<CR>", {silent = true})
    -- map('n', '<F9>', ":DapStepOut<CR>", {silent = true})
    -- map('n', '<leader>b', ":DapToggleBreakpoint<CR>", {silent = true})

    -- require("dapui").setup()
    -- local dap, dapui =require("dap"),require("dapui")
    -- dap.listeners.after.event_initialized["dapui_config"]=function()
    --  dapui.open()
    -- end
    -- dap.listeners.before.event_terminated["dapui_config"]=function()
      -- dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"]=function()
      -- dapui.close()
    -- end
    -- vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
    -- vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

end