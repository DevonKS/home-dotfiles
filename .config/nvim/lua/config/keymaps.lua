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
map("n", "<leader>pp", function()
  require("trouble").toggle("workspace_diagnostics")
end, { desc = "Project Problems (Trouble)" })
map("n", "<leader>ps", "<cmd>wa<cr>", { desc = "Save all" })
-- TODO: open project

vim.api.nvim_create_autocmd("FileType", {
  pattern = "clojure",
  group = vim.api.nvim_create_augroup("clojure_only_keymap", { clear = true }),
  callback = function(event)
    wk.register({ ["<leader>m"] = { buffer = event.buf, name = "+Clojure" } })
    map("n", "<leader>mj", function()
      os.execute("tmux split-window -h 'exec clj -M:repl/conjure'")
    end, { buffer = event.buf, desc = "Start nrepl" })
    map("n", "<leader>mc", "<cmd>ConjureConnect<cr>", { buffer = event.buf, desc = "Connect to nrepl" })
    map("n", "<leader>ml", "<cmd>ConjureEvalFile<cr>", { buffer = event.buf, desc = "Eval File" })
    map("n", "<leader>me", "<cmd>ConjureEval<cr>", { buffer = event.buf, desc = "Eval File" })

    wk.register({ ["<leader>ms"] = { buffer = event.buf, name = "+Slurp" } })
    map("n", "<leader>msf", "<Plug>(sexp_capture_next_element)", { buffer = event.buf, desc = "Slurp Forward" })
    map("n", "<leader>msb", "<Plug>(sexp_capture_prev_element)", { buffer = event.buf, desc = "Slurp Backwards" })

    wk.register({ ["<leader>mb"] = { buffer = event.buf, name = "+Barf" } })
    map("n", "<leader>mbf", "<Plug>(sexp_emit_tail_element)", { buffer = event.buf, desc = "Barf Forward" })
    map("n", "<leader>mbb", "<Plug>(sexp_emit_head_element)", { buffer = event.buf, desc = "Barf Backwards" })

    wk.register({ ["<leader>mw"] = { buffer = event.buf, name = "+Wrap" } })
    map(
      "n",
      "<leader>mw(",
      "<Plug>(sexp_round_head_wrap_element)",
      { buffer = event.buf, desc = "Wrap with () and edit at start" }
    )
    map(
      "n",
      "<leader>mw)",
      "<Plug>(sexp_round_tail_wrap_element)",
      { buffer = event.buf, desc = "Wrap with () and edit at end" }
    )
    map(
      "n",
      "<leader>mw[",
      "<Plug>(sexp_square_head_wrap_element)",
      { buffer = event.buf, desc = "Wrap with [] and edit at start" }
    )
    map(
      "n",
      "<leader>mw]",
      "<Plug>(sexp_square_tail_wrap_element)",
      { buffer = event.buf, desc = "Wrap with [] and edit at end" }
    )
    map(
      "n",
      "<leader>mw{",
      "<Plug>(sexp_curly_head_wrap_element)",
      { buffer = event.buf, desc = "Wrap with {} and edit at start" }
    )
    map(
      "n",
      "<leader>mw}",
      "<Plug>(sexp_curly_tail_wrap_element)",
      { buffer = event.buf, desc = "Wrap with {} and edit at end" }
    )

    wk.register({ ["<leader>mf"] = { buffer = event.buf, name = "+Form" } })
    map("n", "<leader>mfr", "<Plug>(sexp_raise_element)", { buffer = event.buf, desc = "Raise Element" })
    map("n", "<leader>mfR", "<Plug>(sexp_raise_list)", { buffer = event.buf, desc = "Raise Form" })
    map("n", "<leader>mfs", "<Plug>(sexp_splice_list)", { buffer = event.buf, desc = "Splice Form" })

    wk.register({ ["<leader>mt"] = { buffer = event.buf, name = "+Transpose" } })
    map(
      "n",
      "<leader>mtf",
      "<Plug>(sexp_swap_element_forward)",
      { buffer = event.buf, desc = "Transpose element forwards" }
    )
    map(
      "n",
      "<leader>mtb",
      "<Plug>(sexp_swap_element_backward)",
      { buffer = event.buf, desc = "Transpose element backwards" }
    )
    map("n", "<leader>mtF", "<Plug>(sexp_swap_list_forward)", { buffer = event.buf, desc = "Transpose list forwards" })
    map(
      "n",
      "<leader>mtB",
      "<Plug>(sexp_swap_list_backward)",
      { buffer = event.buf, desc = "Transpose list backwards" }
    )
  end,
})

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
map("n", "<leader>cp", function()
  require("trouble").toggle("document_diagnostics")
end, { desc = "Problems (Trouble)" })

map("n", "<leader>cj", require("mini.splitjoin").toggle, { desc = "Split/Join Args" })

wk.register({ ["<leader>ce"] = { name = "+errors" } })
map("n", "<leader>cel", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>cep", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>', { desc = "Previous Error" })
map("n", "<leader>cen", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>', { desc = "Next Error" })
map("n", "<leader>cea", function()
  require("trouble").toggle("document_diagnostics")
end, { desc = "All Errors (Trouble)" })
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
-- gc
map("n", "<leader>cc", function()
  return require("mini.comment").operator() .. "_"
end, { desc = "Toggle Comment", expr = true, remap = true })
map("x", "<leader>cc", [[:<c-u>lua MiniComment.operator('visual')<cr>]], { desc = "Toggle Comment", remap = true })

-- FIXME: for some reason these don't seem to remap
map("n", "<C-/>", function()
  return require("mini.comment").operator() .. "_"
end, { desc = "Toggle Comment", expr = true, remap = true })
map("x", "<C-/>", [[:<c-u>lua MiniComment.operator('visual')<cr>]], { desc = "Toggle Comment", remap = true })

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

map("n", "<leader>qq", require("confirm-quit").confirm_quit_all, { desc = "Quit all", remap = true })
map("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit all (Don't confirm or save)", remap = true })

require("telescope").load_extension("notify")
map("n", "<leader>hn", function()
  require("telescope").extensions.notify.notify()
end, { desc = "Notify Messages" })
