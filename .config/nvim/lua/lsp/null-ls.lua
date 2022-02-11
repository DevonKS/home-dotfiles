local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load null-ls", "WarningMsg" } }, true, {})
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- golang
    formatting.goimports,
    diagnostics.golangci_lint.with({
      args = {
        "run",
        "-c",
        "/Users/devon/golangci.yml",
        "$DIRNAME",
        "--path-prefix",
        "$ROOT",
      },
    }),

    -- lua
    formatting.stylua,
    diagnostics.selene,

    -- general
    null_ls.builtins.code_actions.refactoring,
  },
  -- format on save logic
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    end
  end,
})
