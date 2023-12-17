return {
  {
    "yutkat/confirm-quit.nvim",
    event = "CmdlineEnter",
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./custom_snippets" } })
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      -- stylua: ignore
    {"<leader>y", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History"},
    },
  },
  { "echasnovski/mini.splitjoin", version = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_c, #opts.sections.lualine_c)
      table.insert(opts.sections.lualine_c, { "filename", path = 1 })
    end,
  },
}
