local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load gitsigns", "WarningMsg" } }, true, {})
  return
end

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
})

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load which-key", "WarningMsg" } }, true, {})
  return
end

wk.register({
  g = {
    name = "git",
    s = { "<cmd>Gitsigns stage_buffer<CR>", "Stage Buffer" },
    u = { "<cmd>Gitsigns reset_buffer_index<CR>", "Reset Buffer Index" },
    r = { "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
    b = { "<cmd>Git blame<CR>", "Blame" },
    h = {
      name = "hunk",
      s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
      u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
      d = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
      n = { "<cmd>Gitsigns next_hunk<CR>", "Next Hunk" },
      p = { "<cmd>Gitsigns previous_hunk<CR>", "Previous Hunk" },
    },
  },
}, { prefix = "<leader>" })
