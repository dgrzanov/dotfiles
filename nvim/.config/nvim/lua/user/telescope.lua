local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup {
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git", "--glob", "!node_modules" },
		},
		live_grep = {
			additional_args = { "--hidden", "--no-ignore", "--glob", "!.git", "--glob", "!node_modules" },
		},
	},
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
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find Git files" })
vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Search project text" })
