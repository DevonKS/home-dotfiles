-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load packer", "WarningMsg" } }, true, {})
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- General Plugins
  use("windwp/nvim-autopairs")
  use("numToStr/Comment.nvim")
  use("moll/vim-bbye")
  use("nvim-lualine/lualine.nvim")
  use("akinsho/toggleterm.nvim")
  use("ahmedkhalf/project.nvim")
  use("lewis6991/impatient.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("goolord/alpha-nvim")
  use("ThePrimeagen/refactoring.nvim")
  use("folke/lua-dev.nvim")
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        highlight = {
          before = "",
          keyword = "bg",
          after = "",
          pattern = [[(KEYWORDS)]], -- pattern or table of patterns, used for highlightng (vim regex)
        },
        search = {
          pattern = [[\b(KEYWORDS)\b]],
        },
      })
    end,
  })
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })
  use({
    "ggandor/leap.nvim",
    requires = "tpope/vim-repeat",
    config = function()
      require("leap").set_default_keymaps()
    end,
  })

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("tpope/vim-fugitive")

  -- Colorschemes
  use("EdenEast/nightfox.nvim")

  -- Keyboard Shortcuts
  use({
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key").setup()
    end,
  })

  -- Icons used by nvim-tree and others
  use("kyazdani42/nvim-web-devicons")

  -- File explorer
  use("kyazdani42/nvim-tree.lua")

  -- Useful lua functions. Used by several plugins like telescope
  use("nvim-lua/plenary.nvim")

  -- Project Navigation
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("f3fora/cmp-spell")
  use("hrsh7th/cmp-nvim-lsp-signature-help")

  -- Snippets
  -- TODO should I use ultisnips and vim-snippets instead?
  -- seems like they have more snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")

  -- Mason (Auto installer)
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jayp0521/mason-null-ls.nvim")

  -- LSP
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/nvim-treesitter-textobjects")

  -- Testing
  use("vim-test/vim-test")
end)
