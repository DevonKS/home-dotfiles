return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable the line diagnostics keymap cause I change it in my keymaps
      keys[#keys + 1] = { "<leader>cd", false }
    end,
    opts = {
      servers = {
        rust_analyzer = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "rust",
      },
    },
  }
}
