M = {}

M.setup = function()
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    vim.api.nvim_echo({ { "Warning: Failed to load which-key", "WarningMsg" } }, true, {})
    return
  end

  wk.register({
    f = {
      name = "file",
      s = { "<cmd>w<cr>", "Save File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    },
    b = {
      name = "buffer",
      k = { "<cmd>Bdelete<cr>", "Kill Buffer" },
      n = { "<cmd>bn<cr>", "Next Buffer" },
      p = { "<cmd>bp<cr>", "Previous Buffer" },
      l = { "<cmd>bl<cr>", "List Buffers" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    },
    w = {
      name = "window",
      h = { "<C-w>h", "Window Left" },
      j = { "<C-w>j", "Window Down" },
      k = { "<C-w>k", "Window Up" },
      l = { "<C-w>l", "Window Right" },
      c = { "<cmd>close<cr>", "Close Window" },
      m = { "<cmd>only<cr>", "Maximise Window" },
    },
    s = {
      name = "search",
      p = { "<cmd>Telescope live_grep<cr>", "Search Project" },
      i = { "<cmd>Telescope treesitter<cr>", "Search Buffer Symbols" },
    },
    p = {
      name = "project",
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      p = {
        name = "packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        d = { "<cmd>PackerClean<cr>", "Clean" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
      },
      o = { "<cmd>Telescope projects<cr>", "Open Project" },
    },
    l = {
      name = "lua",
      l = { "<cmd>luafile %<cr>", "Load" },
    },
    h = {
      name = "help",
      m = { "<cmd>mes<cr>", "messages" },
    },
    t = {
      name = "testing",
      f = { "<cmd>TestFile -strategy=neovim<cr>", "Test File" },
      F = { "<cmd>TestFile<cr>", "Test File" },
      s = { "<cmd>TestNearest -strategy=neovim<cr>", "Test Single" },
      S = { "<cmd>TestNearest<cr>", "Test Single" },
      l = { "<cmd>TestLast -strategy=neovim<cr>", "Test Last" },
      L = { "<cmd>TestLast -strategy=basic<cr>", "Test Last" },
      a = { "<cmd>TestSuite -strategy=neovim<cr>", "Test All" },
      A = { "<cmd>TestSuite<cr>", "Test All" },
    },
    [":"] = { "<cmd>Telescope commands<cr>", "Commands" },
  }, { prefix = "<leader>" })
end

return M
