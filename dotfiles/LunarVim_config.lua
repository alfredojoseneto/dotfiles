-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


 -- Send REPL to Window
lvim.plugins = {
  { "karoliskoncevicius/vim-sendtowindow" },
  { "jamestthompson3/nvim-remote-containers" },
  -- { "lukas-reineke/virt-column.nvim" }
}


-- KEYBIDINGS
lvim.keys.insert_mode["jk"] = "<Esc>"


-- OPTIONS
vim.opt.encoding = "utf-8"
vim.opt.list = true
vim.opt.listchars:append("tab:¦·,trail:·,nbsp:␣,eol:↲,precedes:❮,extends:❯")
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.sidescrolloff = 8
