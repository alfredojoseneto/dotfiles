-- Built-in plugin manager (Neovim 0.12+): no external plugin manager needed
vim.pack.add({
  "https://github.com/Mofiqul/dracula.nvim",
  -- lualine has no release tags; pin to the master commit from 2026-05-31
  {
    src = "https://github.com/nvim-lualine/lualine.nvim",
    version = "221ce6b2d999187044529f49da6554a92f740a96",
  },
})

-- Theme
vim.cmd.colorscheme("dracula")
