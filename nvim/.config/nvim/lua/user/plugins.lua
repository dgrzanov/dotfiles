local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	use "wbthomason/packer.nvim" -- Have packer manage itself
	use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

	-- Autopairs plugin
	use "windwp/nvim-autopairs"

	-- Colorschemes
	use {"shatur/neovim-ayu", disable = true}
	use {"lunarvim/colorschemes", disable = true}
	use {'wojciechkepka/vim-github-dark', disable = true}
	use {'rktjmp/lush.nvim', disable = true}
	use 'sainnhe/everforest'

	-- cmp plugins
	use "hrsh7th/nvim-cmp" -- completion plugin
	use "hrsh7th/cmp-buffer" -- buffer completions
	use "hrsh7th/cmp-path" -- poth completions
	use "hrsh7th/cmp-cmdline" -- cmdline completions
	use "saadparwaiz1/cmp_luasnip" -- snippet completions
	use "hrsh7th/cmp-nvim-lsp" -- built-in LSP completions
	use "hrsh7th/cmp-nvim-lua" -- nvim Lua API completions

	-- snippets
	use "L3MON4D3/LuaSnip" -- snippet engine

	-- LSP
	use "neovim/nvim-lspconfig"
	--use "williamboman/nvim-lsp-installer" -- deprecated TODO replace with mason.nvim
	use "mason-org/mason.nvim"
	use "mason-org/mason-lspconfig.nvim"

	-- Telescope
	use "nvim-telescope/telescope.nvim"

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}

	-- Harpoon
	-- use "theprimeagen/harpoon"

	-- Status line
	use "ojroques/nvim-hardline"

	-- Git
	use "lewis6991/gitsigns.nvim"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
