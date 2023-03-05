local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load null-ls", "WarningMsg" } }, true, {})
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false,
  sources = {
    -- golang
    formatting.goimports.with({ extra_args = { "-local", "git.montoux.com" } }),
    -- FIXME I don't know if this is actually what I want for diagnostics for go.
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

    -- rust
    formatting.rustfmt,

    -- python
    formatting.black,
    diagnostics.pylint,

    -- json
    formatting.jq,
    diagnostics.jsonlint,

    -- general
    null_ls.builtins.code_actions.refactoring,
  },

  -- format on save logic
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              -- apply whatever logic you want (in this example, we'll only use null-ls)
              -- FIXME need to use different ones depending on the lang. Like for golang I think I want to use the lsp? maybe not
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
