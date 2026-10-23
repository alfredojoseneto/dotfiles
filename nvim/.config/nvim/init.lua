-- Leader must be set before any mapping is created and before lazy.nvim loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.options")
require("config.keymaps")
