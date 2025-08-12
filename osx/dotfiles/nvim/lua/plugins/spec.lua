return {
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"hrsh7th/nvim-cmp",
		-- load completions on InsertEnter
		event = "InsertEnter",
		-- lazy load deps when autocompletion loads
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
	},
	{ "mbbill/undotree", lazy = true },
	{ "tpope/vim-fugitive", lazy = true },
	{ "mhartington/formatter.nvim", lazy = true },
	{ "folke/lazydev.nvim", lazy = true, ft = "lua" },
}
