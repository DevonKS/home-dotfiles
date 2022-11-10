local status_ok, t = pcall(require, "telescope")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load telescope", "WarningMsg" } }, true, {})
  return
end

t.load_extension("fzf")

local status_ok, trouble = pcall(require, "trouble.providers.telescope")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load trouble.providers.telescope", "WarningMsg" } }, true, {})
  return
end

t.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
})
