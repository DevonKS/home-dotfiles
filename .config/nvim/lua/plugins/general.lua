return {
  {
    "yutkat/confirm-quit.nvim",
    event = "CmdlineEnter",
    opts = {},
  },
  {
    "garymjr/nvim-snippets",
    opts = {
      friendly_snippets = true,
      search_paths = { vim.fn.stdpath("config") .. "/custom_snippets" },
    },
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      -- stylua: ignore
    {"<leader>y", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History"},
      { "<leader>p", false },
    },
  },
  { "echasnovski/mini.splitjoin", version = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_c[4] = LazyVim.lualine.pretty_path({ length = 0 })
    end,
  },
}
