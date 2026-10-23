-- Statusline. Uses the Dracula palette so it matches the colorscheme.
require("lualine").setup({
  options = {
    theme = "dracula",
    globalstatus = true,
    component_separators = { left = "\u{E0B1}", right = "\u{E0B3}" },
    section_separators = { left = "\u{E0B0}", right = "\u{E0B2}" },
  },
})
