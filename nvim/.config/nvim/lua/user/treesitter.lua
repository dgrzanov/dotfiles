local status_ok, ts = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

-- Parsers to install (needs the `tree-sitter` CLI). Already-installed ones are skipped.
-- Add more here, or install ad hoc with :TSInstall <lang>.
ts.install({ "markdown", "markdown_inline" })

-- Start treesitter highlighting for any filetype that has a parser available.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
