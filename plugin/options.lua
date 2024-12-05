local opt = vim.opt

vim.g.have_nerd_font = true

-- Shows what is being done in the buffer - cool!
opt.inccommand = "split"

-- Search options
opt.smartcase = true
opt.ignorecase = true

-- Show line numbers
opt.number = true

-- Enable mouse mode
opt.mouse = "a"

-- Don't show mode since it's already in the status line
opt.showmode = false

-- Show which brackets are being closed
vim.o.showmatch = true

-- Enable folding
vim.o.foldmethod = "marker"

opt.clipboard = "unnamedplus"

-- Enable break indent
opt.breakindent = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Show which line cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 10

-- For bufferline
opt.termguicolors = true
