local map = vim.keymap.set

-- Type jk to leave insert mode quickly
map("i", "jk", "<Esc>")

-- Clear search highlight
map("n", "<leader>h", "<cmd>nohlsearch<CR>")

-- Keep the cursor centered when jumping between search results
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Yank from cursor to end of line
map("n", "Y", "y$")

-- Split the window horizontally (below) and vertically (right)
map("n", "<C-w>s", "<cmd>split<CR>")
map("n", "<C-w>v", "<cmd>vsplit<CR>")

-- Move between splits with Ctrl+h/j/k/l
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize splits with Ctrl+arrows
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")

-- Move by screen lines when text is wrapped
map("n", "j", "gj")
map("n", "k", "gk")

-- Copy to and paste from the system clipboard
map({ "n", "v" }, "<leader>c", '"+y')
map({ "n", "v" }, "<leader>v", '"+p')

-- List open buffers and start a buffer switch
map("n", "<leader>b", ":ls<CR>:buffer<Space>")
