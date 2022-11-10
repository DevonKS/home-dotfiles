require("options")
require("keymaps")
require("plugins")
require("plugins.telescope")
require("plugins.cmp")
require("plugins.treesitter")
require("plugins.nvim-treesitter-textobjects")
require("plugins.comment")
require("plugins.autopairs")
require("plugins.lualine")
require("plugins.toggleterm")
require("plugins.project")
require("plugins.indent-blankline")
require("plugins.alpha")
require("plugins.git")
require("plugins.nvim-tree")
require("plugins.refactoring")
require("colorschemes.nightfox")
require("lsp")

-- TODO
-- Shortcuts to split new windows
-- Shortcut to find file in current directory
-- Highlight current symbol usage in scope. See the fixme in lsp/init.lua
--
-- Put telescope/other completions into another buffer
-- https://github.com/jose-elias-alvarez/null-ls.nvim which needs https://github.com/tamago324/nlsp-settings.nvim. See https://www.youtube.com/watch?v=ryxRpKpM9B4
-- look into null-ls spell completion
-- DONE See https://www.youtube.com/watch?v=xr5XWR9UxHA
--
-- Things of interest
-- https://github.com/uga-rosa/cmp-dictionary
-- https://github.com/nvim-treesitter/playground
-- https://github.com/romgrk/nvim-treesitter-context
-- https://github.com/folke/trouble.nvim
-- https://github.com/folke/persistence.nvim

-- TODO golang
-- codelenses
-- gomodifytags
-- jsontostruct
-- integration with Telescope for a number of file picking needs
-- switch to the test/code file quickly
-- github.com/cweill/gotests
-- coverage support: annotate the current buffer and store coverage data for all files affected screencast
