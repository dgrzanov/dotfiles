local opts = { noremap = true, silent = true }


--Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL --
-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- File explorer
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

--Resize with arrows
keymap("n", "<C-Up>", ":resize +2<cr>", opts)
keymap("n", "<C-Down>", ":resize -2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- Cursor stays in same location when pressing J
keymap("n", "J", "mzJ`z", opts)

-- Cursor stays in middle when jumping
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Search terms stay in middle
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Copy to system register
keymap("n", "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]], opts)
keymap("n", "<leader>d", [["_d]], opts)

-- Replace all occurences of a word
keymap("n", "<leader>cr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)


-- INSERT --


-- VISUAL --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Copy to system register
keymap("v", "<leader>y", [["+y]], opts)
keymap("v", "<leader>d", [["_d]], opts)

-- Native commenting with Space followed by /.
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle line comment" })
vim.keymap.set("x", "<leader>/", "gc", { remap = true, desc = "Toggle selected comments" })
vim.keymap.set("n", "<leader>gg", function() require("user.lazygit").open() end,
  { desc = "Open LazyGit" })
vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = false }) end,
  { desc = "Show buffer keybindings" })
vim.keymap.set("n", "<leader>ch", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

-- Describe the existing mappings so which-key can explain them too.
local descriptions = {
  n = { ["<C-h>"] = "Window left", ["<C-j>"] = "Window below", ["<C-k>"] = "Window above",
    ["<C-l>"] = "Window right", ["<C-Up>"] = "Increase height", ["<C-Down>"] = "Decrease height",
    ["<C-Left>"] = "Decrease width", ["<C-Right>"] = "Increase width", ["J"] = "Join lines",
    ["<C-d>"] = "Half page down centered", ["<C-u>"] = "Half page up centered",
    ["n"] = "Next match centered", ["N"] = "Previous match centered",
    ["<leader>y"] = "Copy to clipboard", ["<leader>Y"] = "Copy line to clipboard",
    ["<leader>d"] = "Delete without yanking", ["<leader>cr"] = "Replace word throughout file" },
  x = { ["<"] = "Indent left", [">"] = "Indent right", ["J"] = "Move lines down",
    ["K"] = "Move lines up", ["<leader>y"] = "Copy to clipboard", ["<leader>d"] = "Delete without yanking" },
}
for mode, mappings in pairs(descriptions) do
  for lhs, desc in pairs(mappings) do
    local mapping = vim.fn.maparg(lhs, mode, false, true)
    if mapping.rhs then vim.keymap.set(mode, lhs, mapping.rhs, { silent = true, desc = desc }) end
  end
end
