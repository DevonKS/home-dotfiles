local status_ok, nf = pcall(require, "nightfox")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load nightfox theme", "WarningMsg" } }, true, {})
  return
end

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nf.setup({
  fox = "nordfox",
})

nf.load()
