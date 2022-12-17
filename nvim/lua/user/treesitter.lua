local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end


configs.setup {
	ensure_installed = {"help", "javascript", "typescript", "lua", "python", "c"},
	sync_install = false,
	auto_install = true,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		--disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,

	},
	--indent = { enable = true, disable = { "yaml" } },
}
