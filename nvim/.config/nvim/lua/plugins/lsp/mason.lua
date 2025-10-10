return {
  "williamboman/mason.nvim",
  dependencies = {
    -- "williamboman/mason-lspconfig.nvim",
    -- "jose-elias-alvarez/null-ls.nvim",
    -- "jayp0521/mason-null-ls.nvim",
    -- "jay-babu/mason-null-ls.nvim",
    -- "neovim/nvim-lspconfig",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-null-ls
    local mason_null_ls = require("mason-null-ls")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
