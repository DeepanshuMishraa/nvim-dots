
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  use('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})  
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use {
	  "VonHeikemen/lsp-zero.nvim",
	  branch = "v1.x",
	  requires = {
		  -- LSP Support
		  {"neovim/nvim-lspconfig"},
		  {"williamboman/mason.nvim"},
		  {"williamboman/mason-lspconfig.nvim"},

		  -- Autocompletion
		  {"hrsh7th/nvim-cmp"},
		  {"hrsh7th/cmp-buffer"},
		  {"hrsh7th/cmp-path"},
		  {"saadparwaiz1/cmp_luasnip"},
		  {"hrsh7th/cmp-nvim-lsp"},
		  {"hrsh7th/cmp-nvim-lua"},

		  -- Snippets
		  {"L3MON4D3/LuaSnip"},
		  {"rafamadriz/friendly-snippets"},
	  }
  }
  use('github/copilot.vim')
  use('b0o/schemastore.nvim')
  use 'wakatime/vim-wakatime'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use {
  'vyfor/cord.nvim',
  run = ':Cord update',
  config = function()
    require('cord').setup {}
  end
}
use('jose-elias-alvarez/null-ls.nvim')
use {
  "alex-popov-tech/store.nvim",
  config = function()
    require('store').setup {}
  end
}
end)

