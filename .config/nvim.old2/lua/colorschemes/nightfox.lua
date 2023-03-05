local status_ok, nf = pcall(require, "nightfox")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load nightfox theme", "WarningMsg" } }, true, {})
  return
end

vim.cmd("colorscheme nordfox")
