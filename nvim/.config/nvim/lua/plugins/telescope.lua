-- Directory Neovim was started in; find_files always searches from here
local start_dir = vim.uv.cwd()

return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      -- hidden = true lists .git internals too; keep them out of the results
      file_ignore_patterns = { "%.git/", "%.DS_Store$" },
    },
    pickers = {
      -- Include dotfiles and dot-directories (.config, .tmux.conf, ...)
      find_files = { hidden = true },
    },
  },
  keys = {
    {
      "<leader>t",
      function()
        require("telescope.builtin").find_files({ cwd = start_dir })
      end,
      desc = "Find files",
    },
  },
}
