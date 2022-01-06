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

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- General Plugins
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use 'akinsho/bufferline.nvim'
  use 'moll/vim-bbye'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'ahmedkhalf/project.nvim'
  use 'lewis6991/impatient.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'goolord/alpha-nvim'

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'

  -- Colorschemes
  use 'EdenEast/nightfox.nvim'

  -- Keyboard Shortcuts
  use {
    'folke/which-key.nvim',
    config = function()
      require('plugins.which-key').setup()
    end
  }

  -- Icons used by nvim-tree and others
  use 'kyazdani42/nvim-web-devicons'

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- Useful lua functions. Used by several plugins like telescope
  use 'nvim-lua/plenary.nvim'

  -- Project Navigation
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'f3fora/cmp-spell'

  -- Snippets
  -- TODO should I use ultisnips and vim-snippets instead?
  -- seems like they have more snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use 'p00f/nvim-ts-rainbow'
end)
