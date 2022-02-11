local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load lspconfig", "WarningMsg" } }, true, {})
  return
end

require("lsp.lsp-installer")
require("lsp.handlers").setup()
require("lsp.null-ls")
