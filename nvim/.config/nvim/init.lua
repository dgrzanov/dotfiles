vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Disable netrw before plugins load; nvim-tree owns directory buffers.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require "user.options"
require "user.keymaps"
require "user.plugins"
