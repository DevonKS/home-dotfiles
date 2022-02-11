local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load impatient", "WarningMsg" } }, true, {})
  return
end

impatient.enable_profile()
