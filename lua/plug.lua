-- [[ plug.lua ]]

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }
    if not vim.g.vscode then
      use { 'nvim-tree/nvim-web-devicons' }
      use {                                              -- filesystem navigation
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons'        -- filesystem icons
      }
      use { 'mhinz/vim-startify' }
      use { 'DanilaMihailov/beacon.nvim' }
      use {
          'nvim-lualine/lualine.nvim',
          requires = { 'nvim-tree/nvim-web-devicons', opt = true}
      }
      use { 'rktjmp/lush.nvim' }
      use { 
          'ViviDboarder/wombat.nvim',
          requires = 'rktjmp/lush.nvim'
      }
--      use {
--	  "rockyzhang24/arctic.nvim",
--      requires = "rktjmp/lush.nvim"
--      }
      --use { 'tpope/vim-fugitive' }
      use { 'airblade/vim-gitgutter'}
      use { 'f-person/git-blame.nvim'}
      use { 'github/copilot.vim' }
    end

    use { 'windwp/nvim-autopairs' }
    use { 'tpope/vim-commentary' }

--    use { 'mfussenegger/nvim-dap' }
--    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

--    local dap = require('dap')
--    dap.adapters.cppdbg = {
--        id = 'cppdbg',
--       type = 'executable',
--        command = '/home/mep/.vscode/extensions/ms-vscode.cpptools-1.18.5-linux-x64/debugAdapters/bin/OpenDebugAD7',
--	options = {
--		detached = false
--	}
--    }
--    dap.configurations.cpp = {
--      {
--        name = "Launch file",
--        type = "cppdbg",
--        request = "launch",
--        program = function()
--          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--        end,
--        cwd = '${workspaceFolder}',
--        stopAtEntry = true,
--      },
--      {
--        name = 'Attach to gdbserver :1234',
--        type = 'cppdbg',
--        request = 'launch',
--        MIMode = 'gdb',
--        miDebuggerServerAddress = 'localhost:1234',
--        miDebuggerPath = '/usr/bin/gdb',
--        cwd = '${workspaceFolder}',
--        program = function()
--          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--        end,
--      },
--   }
   end)
