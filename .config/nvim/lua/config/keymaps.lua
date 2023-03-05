-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local wk = require("which-key")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("i", "jk", "<ESC>", { noremap = true, silent = true })

-- Files
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save File" })

-- Buffers
map("n", "<leader>bk", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete Buffer" })

-- Windows
map("n", "<leader>wh", "<C-w>h", { desc = "Window Left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Window Down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Window Up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Window Right" })

map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close Window" })
map("n", "<leader>wm", "<cmd>only<cr>", { desc = "Maximise Window" })

map("n", "<leader>ws", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right" })

-- Search
map("n", "<leader>sp", Util.telescope("live_grep"), { desc = "Search Project" })
map("n", "<leader>si", Util.telescope("treesitter"), { desc = "Search Buffer Symbols" })

-- Project
wk.register({ p = { name = "+project" } })
map("n", "<leader>pf", Util.telescope("files"), { desc = "Find File" })
-- TODO: open project

-- Config
-- TODO: reload config
-- TODO: load lua file

-- Testing
-- TODO: Test current file
-- TODO: Test current function
-- TODO: Test Last
-- TODO: Test All

-- LSP
-- TODO: goto definition
-- TODO: goto references
-- TODO: show problems
-- TODO: next error
-- TODO: previous error
-- TODO: show error under cursor
-- TODO: list errors (how is this different from show problems?)
-- TODO: show docs
-- TODO: show signature help
-- TODO: show available refactors

-- Comment
-- TODO: toggle comment normal mode
-- TODO: toggle comment Visual mode

-- GIT
-- TODO: stage buffer
-- TODO: reset buffer
-- TODO: blame
-- TODO: diff current file to index in vimdiff
-- TODO: diff current file to somewhere in vimdiff
-- TODO: stage hunk
-- TODO: undo stage hunk
-- TODO: reset hunk
-- TODO: preview hunk
-- TODO: next hunk
-- TODO: previous hunk

-- Spelling
-- TODO: fix spelling
-- TODO: add to dict
-- TODO: next spelling error
-- TODO: previous spelling error
-- TODO: mark as incorrect
-- TODO: enable spell check
-- TODO: disable spell check

-- Help
wk.register({ p = { name = "+help" } })
map("n", "<leader>hm", "<cmd>mes<cr>", { desc = "Messages" })
