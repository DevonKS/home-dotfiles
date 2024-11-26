return {
  -- add nightfox
  {
    "EdenEast/nightfox.nvim",
    opts = {
      groups = {
        nordfox = {
          SpellBad = { fg = "palette.red" },
        },
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordfox",
    },
  },
}
