local M = {
  "lukas-reineke/indent-blankline.nvim",
}

function M.config()
  local icons = require "icons"
  require("ibl").setup {
    indent = {
      char = icons.ui.LineLeft,
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      injected_languages = true,
      show_exact_scope = false,
    },
    exclude = {
      filetypes = {
        "help",
        "lazy",
        "neo-tree",
        "notify",
        "text",
        "startify",
        "dashboard",
        "neogitstatus",
        "NvimTree",
        "Trouble",
      },
      buftypes = { "terminal", "nofile" },
    },
  }
end

return M
