-- Ensure that Packer is installed.
-- Return true for a fresh install, false for an existing install.
local function ensure_packer()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

-- Ensure Packer is installed.
local packer_bootstrap = ensure_packer()

-- Set up an autocmd so that any edits to this file automatically recompile packer's compiled loader file.
vim.cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'

-- Plugin initialized. Used as a callback to packer.startup()
local function plugins(use)
	use 'wbthomason/packer.nvim'

	-- Colorscheme
	use {
		'folke/tokyonight.nvim',
		config = function()
			vim.cmd 'colorscheme tokyonight-storm'
		end,
	}

	-- Startup screen
	use {
		'goolord/alpha-nvim',
		config = function ()
			require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		end
	}

	-- Telescope, a handy fuzzyfinder list
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Tree sitter, fancy syntax highlighting
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- Undotree, no more losing things with an accidental redo
	use 'mbbill/undotree'

	-- Vim-fugitive, git commands from within vim
	use 'tpope/vim-fugitive'

	if packer_bootstrap then
		require('packer').sync()
	end

	-- LSP-zero, simple Language Server Protocol setup
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}

	-- formatter.nvim, manages code formatters like Prettier
	use 'mhartington/formatter.nvim'
end

return require('packer').startup(plugins)
