local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup {
	defaults = {
		mappings = {
			i = {
				["<CR>"] = actions.select_tab,
			}
		}
	}
}

local builtin = require("telescope.builtin")

-- KEYBINDINGS
vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>s", builtin.live_grep, {})
