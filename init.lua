-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- plugins
require("lazy").setup({
	-- Git related plugins
	'tpope/vim-fugitive',
	'lewis6991/gitsigns.nvim',

	-- LSP Plugins
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		}
	},

	-- Colorscheme and plugins
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	-- Lua line
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = 'tokyonight',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	-- comment gcc gbc
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		lazy = false,
	},

	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'hrsh7th/nvim-cmp' }
		},
	}

})


require('lualine').setup()
require('gitsigns').setup()
require('Comment').setup()
require('telescope').setup { defaults = {
	mappings = {
		i = {
			['<C-u>'] = false, -- kill scroll
			['<C-d>'] = false,
		},
	},
},
}
pcall(require('telescope').load_extension, 'fzf')

require('mason').setup()
require('mason-lspconfig').setup()
require('gdog.keymaps').setup()
require('gdog.options')
require('gdog.lsp')
require('gdog.treesitter')
require('gdog.cmp')
