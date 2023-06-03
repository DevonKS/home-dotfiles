-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local wk = require("which-key")

-- FIXME: Do I have to redefine the map function from the default keymaps file or is there a better way to do this?
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
map(
  "n",
  "<leader>bb",
  "<cmd>Telescope buffers show_all_buffers=true sort_lastused=true<cr>",
  { desc = "Switch Buffers" }
)
map("n", "<leader>b<Tab>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

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
wk.register({ ["<leader>p"] = { name = "+project" } })
map("n", "<leader>pf", Util.telescope("files"), { desc = "Find File" })
-- TODO: open project

-- Config
-- TODO: reload config
wk.register({ ["<leader>n"] = { name = "+neovim" } })
map("n", "<leader>nl", "<cmd>luafile %<cr>", { desc = "Load Current Lua File" })
map("n", "<leader>no", "<cmd>e /Users/devon/.config/nvim/init.lua<cr>", { desc = "Open NeoVim Config" })

-- Testing
wk.register({ ["<leader>t"] = { name = "+testing" } })
map("n", "<leader>tf", "<cmd>TestFile -strategy=neovim<cr>", { desc = "Test File" })
map("n", "<leader>tF", "<cmd>TestFile<cr>", { desc = "Test File (Not NeoVim UI)" })
map("n", "<leader>ts", "<cmd>TestNearest -strategy=neovim<cr>", { desc = "Test Single" })
map("n", "<leader>tS", "<cmd>TestNearest<cr>", { desc = "Test Single (Not NeoVim UI)" })
map("n", "<leader>tl", "<cmd>TestLast -strategy=neovim<cr>", { desc = "Test Last" })
map("n", "<leader>tL", "<cmd>TestLast -strategy=basic<cr>", { desc = "Test Last (Not NeoVim UI)" })
map("n", "<leader>ta", "<cmd>TestSuite -strategy=neovim<cr>", { desc = "Test All" })
map("n", "<leader>tA", "<cmd>TestSuite<cr>", { desc = "Test All (Not NeoVim UI)" })

-- LSP
map("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Goto Definition", remap = true })
map("n", "<leader>cD", Util.telescope("lsp_references"), { desc = "Goto References" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>cp", "<cmd>Trouble document_diagnostics<cr>", { desc = "Problems (Trouble)" })

wk.register({ ["<leader>ce"] = { name = "+errors" } })
map("n", "<leader>cel", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>cep", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>', { desc = "Previous Error" })
map("n", "<leader>cen", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>', { desc = "Next Error" })
map("n", "<leader>cea", "<cmd>Trouble document_diagnostics<cr>", { desc = "All Errors (Trouble)" })
map("n", "<leader>ceg", "<cmd>Telescope diagnostics<cr>", { desc = "Goto Error" })

wk.register({ ["<leader>cg"] = { name = "+goto" } })
map("n", "<leader>cgd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "<leader>cgD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
map("n", "<leader>cgi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
map("n", "<leader>cgr", vim.lsp.buf.references, { desc = "Goto References" })

wk.register({ ["<leader>ch"] = { name = "+help" } })
map("n", "<leader>chk", vim.lsp.buf.hover, { desc = "Show Docs" })
map("n", "<leader>chK", vim.lsp.buf.signature_help, { desc = "Show Signature Help" })

-- TODO: show available refactors

-- Comment
map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })
map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })
map("x", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment" })
map("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment" })

-- GIT
-- TODO: blame entire file
-- TODO: diff current file to index in vimdiff has this with <leader>ghd but it's not that nice to use
-- TODO: diff current file to somewhere in vimdiff
local gs = require("gitsigns")
map("n", "<leader>ghn", gs.next_hunk, { desc = "Next Hunk" })
map("n", "<leader>ghp", gs.prev_hunk, { desc = "Prev Hunk" })
map("n", "<leader>ghd", gs.preview_hunk, { desc = "Preview Hunk" })

-- Spelling
-- TODO: fix spelling
-- TODO: add to dict
-- TODO: next spelling error
-- TODO: previous spelling error
-- TODO: mark as incorrect
-- TODO: enable spell check
-- TODO: disable spell check

-- Help
wk.register({ ["<leader>h"] = { name = "+help" } })
map("n", "<leader>hm", "<cmd>mes<cr>", { desc = "Messages" })

require("telescope").load_extension("notify")
map("n", "<leader>hn", function()
  require("telescope").extensions.notify.notify()
end, { desc = "Notify Messages" })
