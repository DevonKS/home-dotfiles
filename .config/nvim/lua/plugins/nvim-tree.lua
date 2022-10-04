local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load nvim-tree", "WarningMsg" } }, true, {})
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load nvim-tree.config", "WarningMsg" } }, true, {})
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
  },
})

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load which-key", "WarningMsg" } }, true, {})
  return
end

wk.register({
  e = { "<cmd>NvimTreeToggle<cr>", "Nvim Tree" },
}, { prefix = "<leader>" })
