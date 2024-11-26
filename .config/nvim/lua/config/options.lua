-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.conceallevel = 0

vim.opt.spelllang = { "en_nz" }
vim.opt.spellfile = "/Users/devon/.config/nvim/en.utf-8.add"
-- FIXME: This doesn't seem to work?
vim.opt.spelloptions = "camel"

vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }
