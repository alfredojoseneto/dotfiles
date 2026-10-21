local opt = vim.opt

-- Line numbers: absolute number on the cursor line, relative elsewhere
opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- Do not wrap lines. Allow long lines to extend as far as the line goes.
opt.wrap = false

-- Keep some lines around the cursor when scrolling
opt.scrolloff = 10

-- Open splits to the right and below
opt.splitright = true
opt.splitbelow = true

-- Indentation: 4 spaces
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Show tabs, trailing spaces and other invisible characters
opt.list = true
opt.listchars = {
  tab = "¦·",
  trail = "·",
  nbsp = "␣",
  eol = "↲",
  precedes = "❮",
  extends = "❯",
}

-- Clipboard: yank and paste with the system clipboard (pbcopy on macOS)
opt.clipboard = "unnamedplus"

-- Mouse support in all modes
opt.mouse = "a"

-- Colors: required by the Dracula theme
opt.termguicolors = true

-- No backup files
opt.backup = false
opt.writebackup = false
