local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load mason", "WarningMsg" } }, true, {})
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load mason-lspconfig", "WarningMsg" } }, true, {})
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load lspconfig", "WarningMsg" } }, true, {})
  return
end

mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "sumneko_lua", "rust_analyzer", "gopls", "tsserver", "jsonls", "pyright" },
})

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.supports_method("textDocument/documentHighlight") then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>Trouble document_diagnostics<CR>", opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])

  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    vim.api.nvim_echo({ { "Warning: Failed to load which-key", "WarningMsg" } }, true, {})
    return
  end

  wk.register({
    c = {
      name = "code",
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
      D = { "<cmd>Telescope lsp_references<cr>", "Goto References" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      a = { "<cmd>Telescope lsp_code_actions<cr>", "Code Actions" },
      p = { "<cmd>Trouble document_diagnostics<cr>", "Problems" },
      f = { "<cmd>Format<cr>", "Format" },
      e = {
        name = "errors",
        p = { '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>', "Previous Error" },
        n = { '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>', "Next Error" },
        s = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show Error" },
        l = { "<cmd>Trouble document_diagnostics<cr>", "List Errors" },
        g = { "<cmd>Telescope diagnostics<cr>", "Goto Problem" },
      },
      g = {
        name = "go",
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
        r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto References" },
      },
      h = {
        name = "help",
        k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show Docs" },
        K = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature Help" },
      },
    },
  }, { prefix = "<leader>" })

  wk.register({
    c = {
      name = "code",
      r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor" },
    },
  }, { prefix = "<leader>", mode = "v" })
end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load cmp_nvim_lsp", "WarningMsg" } }, true, {})
  return
end
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["tsserver"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["rust_analyzer"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local util = require("lspconfig/util")

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "Pipfile"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
    return path.join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

lspconfig["pyright"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- on_init = function(client)
  --   client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  -- end,
  root_dir = function(fname)
    return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
      or util.path.dirname(fname)
  end,
  settings = {
    ["pyright"] = {
      -- FIXME this doesn't seem to work. I still get import errors for things in the venv
      python = {
        exclude = { ".venv" },
        venvPath = ".",
        venv = ".venv",
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
})

lspconfig["gopls"].setup({
  on_attach = on_attach,
  settings = {
    ["gopls"] = {
      ["local"] = "git.montoux.com",
      buildFlags = { "--tags=jobs" },
    },
  },
  capabilities = capabilities,
})

lspconfig["sumneko_lua"].setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
})

-- Find more schemas here: https://www.schemastore.org/json/
local schemas = {
  {
    description = "TypeScript compiler configuration file",
    fileMatch = {
      "tsconfig.json",
      "tsconfig.*.json",
    },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "Lerna config",
    fileMatch = { "lerna.json" },
    url = "https://json.schemastore.org/lerna.json",
  },
  {
    description = "Babel configuration",
    fileMatch = {
      ".babelrc.json",
      ".babelrc",
      "babel.config.json",
    },
    url = "https://json.schemastore.org/babelrc.json",
  },
  {
    description = "ESLint config",
    fileMatch = {
      ".eslintrc.json",
      ".eslintrc",
    },
    url = "https://json.schemastore.org/eslintrc.json",
  },
  {
    description = "Bucklescript config",
    fileMatch = { "bsconfig.json" },
    url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
  },
  {
    description = "Prettier config",
    fileMatch = {
      ".prettierrc",
      ".prettierrc.json",
      "prettier.config.json",
    },
    url = "https://json.schemastore.org/prettierrc",
  },
  {
    description = "Vercel Now config",
    fileMatch = { "now.json" },
    url = "https://json.schemastore.org/now",
  },
  {
    description = "Stylelint config",
    fileMatch = {
      ".stylelintrc",
      ".stylelintrc.json",
      "stylelint.config.json",
    },
    url = "https://json.schemastore.org/stylelintrc",
  },
  {
    description = "A JSON schema for the ASP.NET LaunchSettings.json files",
    fileMatch = { "launchsettings.json" },
    url = "https://json.schemastore.org/launchsettings.json",
  },
  {
    description = "Schema for CMake Presets",
    fileMatch = {
      "CMakePresets.json",
      "CMakeUserPresets.json",
    },
    url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
  },
  {
    description = "Configuration file as an alternative for configuring your repository in the settings page.",
    fileMatch = {
      ".codeclimate.json",
    },
    url = "https://json.schemastore.org/codeclimate.json",
  },
  {
    description = "LLVM compilation database",
    fileMatch = {
      "compile_commands.json",
    },
    url = "https://json.schemastore.org/compile-commands.json",
  },
  {
    description = "Config file for Command Task Runner",
    fileMatch = {
      "commands.json",
    },
    url = "https://json.schemastore.org/commands.json",
  },
  {
    description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
    fileMatch = {
      "*.cf.json",
      "cloudformation.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
  },
  {
    description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
    fileMatch = {
      "serverless.template",
      "*.sam.json",
      "sam.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
  },
  {
    description = "Json schema for properties json file for a GitHub Workflow template",
    fileMatch = {
      ".github/workflow-templates/**.properties.json",
    },
    url = "https://json.schemastore.org/github-workflow-template-properties.json",
  },
  {
    description = "golangci-lint configuration file",
    fileMatch = {
      ".golangci.toml",
      ".golangci.json",
    },
    url = "https://json.schemastore.org/golangci-lint.json",
  },
  {
    description = "JSON schema for the JSON Feed format",
    fileMatch = {
      "feed.json",
    },
    url = "https://json.schemastore.org/feed.json",
    versions = {
      ["1"] = "https://json.schemastore.org/feed-1.json",
      ["1.1"] = "https://json.schemastore.org/feed.json",
    },
  },
  {
    description = "Packer template JSON configuration",
    fileMatch = {
      "packer.json",
    },
    url = "https://json.schemastore.org/packer.json",
  },
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
  {
    description = "JSON schema for Visual Studio component configuration files",
    fileMatch = {
      "*.vsconfig",
    },
    url = "https://json.schemastore.org/vsconfig.json",
  },
  {
    description = "Resume json",
    fileMatch = { "resume.json" },
    url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
  },
}

lspconfig["jsonls"].setup({
  on_attach = on_attach,
  settings = {
    json = {
      schemas = schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  },
  capabilities = capabilities,
})

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  -- disable virtual text
  virtual_text = true,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

require("lsp.null-ls")

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load mason-null-ls", "WarningMsg" } }, true, {})
  return
end

mason_null_ls.setup({
  ensure_installed = { "stylua", "selene", "rustfmt", "pylint", "black", "goimports", "jsonlint", "jq" },
})
