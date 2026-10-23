return {
  "Mofiqul/dracula.nvim",
  -- Load the theme before other plugins so their highlights match
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("dracula")
  end,
}
