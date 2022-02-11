require("options")
require("keymaps")
require("plugins")
require("plugins.telescope")
require("plugins.cmp")
require("plugins.treesitter")
require("plugins.comment")
require("plugins.autopairs")
require("plugins.bufferline")
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
-- https://github.com/jose-elias-alvarez/null-ls.nvim which needs https://github.com/tamago324/nlsp-settings.nvim. See https://www.youtube.com/watch?v=ryxRpKpM9B4
-- look into null-ls spell completion
-- DONE See https://www.youtube.com/watch?v=xr5XWR9UxHA
-- DONE Make the entire filepath appear in bufferline
--
-- Things of interest
-- https://github.com/uga-rosa/cmp-dictionary
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- https://github.com/nvim-treesitter/playground
-- https://github.com/romgrk/nvim-treesitter-context
-- https://github.com/folke/trouble.nvim
-- https://github.com/folke/persistence.nvim

-- TODO golang
-- List from goldsmith that I want:
-- codelens support screencast
-- flag and update out-of-date dependencies in your current Go module screencast
-- treesitter navigation utilizing the nvim-treesitter-textobjects plugin
-- treesitter text objects utilizing the nvim-treesitter-textobjects plugin
-- convert JSON to Go structs directly in your code, or paste from outside the editor screencast
-- view Go documentation using the :GoDoc command and Go help with :GoHelp screencast. I kinda already have docs of thing at point, might be nice to add this too.
-- integration with Telescope for a number of file picking needs screencast
-- switch to the test/code file quickly screencast
-- generate test stubs automatically using gotests screencast
-- create implementation stubs for your interfaces using :GoImpl screencast
-- struct tag editing: add / remove / update struct tags and options screencast
-- coverage support: annotate the current buffer and store coverage data for all files affected screencast
-- statusline integration: see the status of running jobs and of coverage data for the current buffer screencast
-- use the excellent builtin testing framework to run individual tests, package tests, or all your tests
-- use common go subcommands from within Neovim with: :GoBuild, :GoInstall, :GoGet, :GoRun, and others screencast
-- edit the go.mod file from within Neovim with: :GoModTidy, :GoModCheck, :GoModRetract, :GoModReplace, and others
