local status_ok, t = pcall(require, "telescope")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load telescope", "WarningMsg" } }, true, {})
  return
end

t.load_extension("fzf")
