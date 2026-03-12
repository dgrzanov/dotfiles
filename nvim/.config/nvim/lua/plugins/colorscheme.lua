return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    init = function()
      vim.o.background = "dark" -- dark variant
      -- optional contrast: "soft" | "medium" | "hard" (default: "medium")
      -- vim.g.everforest_background = "hard"
      -- optional extras:
      -- vim.g.everforest_enable_italic = 1
      -- vim.g.everforest_transparent_background = 1
    end,
  },

  -- Configure LazyVim to load everforest
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
