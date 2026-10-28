-- Netrw file explorer (built into Neovim, no plugin needed)
vim.g.netrw_banner = 0 -- hide the help banner
vim.g.netrw_winsize = 20 -- explorer takes 20% of the width
-- Open the vertical split on the left side. netrw flips this when splitright is set
vim.g.netrw_altv = 0

-- Toggle the explorer on the left side
vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<CR>")
