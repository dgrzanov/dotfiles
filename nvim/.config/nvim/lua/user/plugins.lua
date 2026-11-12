local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath })
  if vim.v.shell_error ~= 0 then error("Unable to install lazy.nvim: " .. output) end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "dgrzanov/lcars.nvim", lazy = false, priority = 1000,
    config = function() vim.cmd.colorscheme("lcars") end },
  { "hrsh7th/nvim-cmp", dependencies = {
    "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua",
  }, config = function() require "user.cmp" end },
  { "windwp/nvim-autopairs", dependencies = { "hrsh7th/nvim-cmp" },
    config = function() require "user.autopairs" end },
  { "neovim/nvim-lspconfig", dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  }, config = function() require "user.lsp" end },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require "user.telescope" end },
  -- `main` is the Neovim 0.12+ rewrite; it does not support lazy-loading.
  { "nvim-treesitter/nvim-treesitter", branch = "main", lazy = false, build = ":TSUpdate",
    config = function() require "user.treesitter" end },
  { "nvim-lualine/lualine.nvim", dependencies = { "dgrzanov/lcars.nvim", "nvim-tree/nvim-web-devicons" },
    config = function() require "user.lualine" end },
  { "lewis6991/gitsigns.nvim", config = function() require "user.gitsigns" end },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require "user.nvim-tree" end },
  { "folke/which-key.nvim", opts = {
    delay = 300,
    spec = {
      { "<leader>g", group = "Git" },
      { "<leader>c", group = "Code" },
      { "<leader>b", group = "Buffer / blame" },
    },
  } },
  { "mfussenegger/nvim-lint", config = function() require "user.lint" end },
  { "sphamba/smear-cursor.nvim", opts = { smear_in_insert_mode = false } },
}, {
  -- Separate from any previous LazyVim installation on this machine.
  root = vim.fn.stdpath("data") .. "/lazy-user",
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  checker = { enabled = false },
  change_detection = { enabled = false, notify = false },
  install = { missing = false },
  local_spec = false,
  performance = { reset_packpath = true },
})
