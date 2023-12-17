return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable the line diagnostics keymap cause I change it in my keymaps
      keys[#keys + 1] = { "<leader>cd", false }
    end,
    opts = {
      format = {
        -- NOTE: goimports can sometimes take long that's why this is so high
        timeout_ms = 5000,
      },
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                fieldalignment = false,
                -- shadow = true,
                unusedvariable = true,
              },
            },
          },
        },
        clojure_lsp = {},
      },
      setup = {
        gopls = function() end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "clojure",
        "terraform",
      },
    },
  },
}
