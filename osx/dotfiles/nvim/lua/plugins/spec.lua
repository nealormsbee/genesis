local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme
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
		version = false, -- last official release is super old, so don't bind to a version. Just use latest.
		-- load completions plugin when entering Insert mode.
		event = "InsertEnter",
		-- lazy load deps when autocompletion loads
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}, { { name = "buffer" } }),

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = {
					["<Down>"] = function(fallback)
						if not cmp.select_next_item() then
							if vim.bo.buftype ~= "prompt" and has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end
					end,
					["<Up>"] = function(fallback)
						if not cmp.select_prev_item() then
							if vim.bo.buftype ~= "prompt" and has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end
					end,
					["<Tab>"] = function(fallback)
						if not cmp.select_next_item() then
							if vim.bo.buftype ~= "prompt" and has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end
					end,
					["<S-Tab>"] = function(fallback)
						if not cmp.select_prev_item() then
							if vim.bo.buftype ~= "prompt" and has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end
					end,
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig["lua_ls"].setup({ capabilities = capabilities })
			lspconfig["ts_ls"].setup({ capabilities = capabilities })
			lspconfig["eslint"].setup({ capabilities = capabilities })
			lspconfig["gopls"].setup({ capabilities = capabilities })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = "BufReadPost",
		config = function(_, servers)
			for server, opts in pairs(servers) do
				require("lspconfig")[server].setup(opts)
			end
		end,
	},
	{ "mbbill/undotree", lazy = true },
	{ "tpope/vim-fugitive", lazy = true },
	{ "mhartington/formatter.nvim", lazy = true },
	{ "folke/lazydev.nvim", lazy = true, ft = "lua" },
}
