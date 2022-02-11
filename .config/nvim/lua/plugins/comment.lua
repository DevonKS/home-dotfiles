local status_ok, c = pcall(require, "Comment")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load Comment", "WarningMsg" } }, true, {})
  return
end
c.setup()

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load which-key", "WarningMsg" } }, true, {})
  return
end

wk.register({
  ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<cr>', "toggle comment" },
}, { prefix = "<leader>" })
wk.register({
  ["/"] = { '<esc><cmd>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<cr>', "toggle comment" },
}, { prefix = "<leader>", mode = "v" })

local function map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

-- # NORMAL mode

-- Linewise toggle current line using C-/
map("n", "<C-_>", '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')

-- Blockwise toggle current line using C-\
map("n", "<C-\\>", '<CMD>lua require("Comment.api").toggle_current_blockwise()<CR>')

-- # VISUAL mode

-- Linewise toggle using C-/
map("x", "<C-_>", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
