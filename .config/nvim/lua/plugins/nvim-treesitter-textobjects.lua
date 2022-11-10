local status_ok, nvim_ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.api.nvim_echo({ { "Warning: Failed to load nvim-treesitter configs", "WarningMsg" } }, true, {})
  return
end

nvim_ts_configs.setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>rp"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>rP"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
      },
    },
  },
})
