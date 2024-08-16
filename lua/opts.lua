--[[ opts.lua ]]
local opt = vim.opt

-- [[ Context ]]
opt.colorcolumn = '80'           -- str:  Show col for max line length
opt.number = true                -- bool: Show line numbers
opt.relativenumber = false        -- bool: Show relative line numbers
opt.scrolloff = 4                -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use


-- [[ Search ]]
opt.ignorecase = true            -- bool: Ignore case in search patterns
opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
opt.incsearch = true             -- bool: Use incremental search
opt.hlsearch = false             -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 4               -- num:  Size of an indent
opt.softtabstop = 4              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4                  -- num:  Number of spaces tabs count for

opt.smartindent = true

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one

-- [[ Command timeout ]]
opt.timeoutlen = 200

-- [[ Clipboard ]]
opt.clipboard = 'unnamedplus'

-- [[ Theme ]]
-- opt.syntax = "ON"                -- str:  Allow syntax highlighting
-- opt.termguicolors = true         -- bool: If term supports ui color then enable

require("mason").setup()
require("mason-lspconfig").setup() -- { ensure_installed = {'pyright'}, }

-- [[ LSP ]]
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
local opts = { noremap = true, silent = true }
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
    },
}

-- Enable the following language servers
local servers = { 'pyright' } -- 'clangd', 'pyright', 'gopls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
end

require("bufferline").setup{
    options = {
        diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end
    },
}
