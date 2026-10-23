-- Leader must be set before any mapping is created
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.plugins")
require("config.statusline")
