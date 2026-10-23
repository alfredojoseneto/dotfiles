return {
  "nvim-lualine/lualine.nvim",
  -- lualine has no release tags; pin to the master commit from 2026-05-31
  commit = "221ce6b2d999187044529f49da6554a92f740a96",
  opts = {
    options = {
      theme = "dracula",
      globalstatus = true,
      component_separators = { left = "\u{E0B1}", right = "\u{E0B3}" },
      section_separators = { left = "\u{E0B0}", right = "\u{E0B2}" },
    },
  },
}
