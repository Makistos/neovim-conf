-- [[ plug.lua ]]

return require('packer').startup(function(use)
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
      --use { 'tpope/vim-fugitive' }
      use { 'airblade/vim-gitgutter'}
      use { 'f-person/git-blame.nvim'}
      use { 'github/copilot.vim' }
    end

    use { 'windwp/nvim-autopairs' }
    use { 'tpope/vim-commentary' }
    end)
