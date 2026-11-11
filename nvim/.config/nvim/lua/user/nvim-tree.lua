require("nvim-tree").setup({
  hijack_netrw = true,
  sync_root_with_cwd = true,
  update_focused_file = { enable = true },
  view = { width = 30, side = "left" },
  renderer = { highlight_git = true, root_folder_label = ":t" },
  diagnostics = { enable = true },
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "?", api.tree.toggle_help,
      { buffer = bufnr, desc = "Tree help", silent = true, nowait = true })
  end,
})
