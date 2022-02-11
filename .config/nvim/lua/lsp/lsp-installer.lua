local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load nvim-lsp-installer", "WarningMsg" } }, true, {})
  return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("lsp.handlers").on_attach,
    capabilities = require("lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require("lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)

    local lua_dev_ok, lua_dev = pcall(require, "lua-dev")
    if lua_dev_ok then
      opts = vim.tbl_deep_extend("force", lua_dev.setup(), opts)
    else
      vim.api.nvim_echo({ { "Warning: Failed to load lua-dev", "WarningMsg" } }, true, {})
    end
  end

  if server.name == "gopls" then
    local gopls_opts = require("lsp.settings.gopls")
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
