local refactoring_status_ok, refactoring = pcall(require, "refactoring")
if not refactoring_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load refactoring", "WarningMsg" } }, true, {})
  return
end

refactoring.setup()

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load telescope", "WarningMsg" } }, true, {})
  return
end

telescope.load_extension("refactoring")
