M = {}

M.setup = function()
  local wk = require('which-key')

  wk.register({
    f = {
      name = 'file',
      s = { "<cmd>w<cr>", "Save File"},
      r = { '<cmd>Telescope oldfiles<cr>', 'Recent Files'}
    },
    b = {
      name = 'buffer',
      k = { "<cmd>Bdelete<cr>", "Kill Buffer" },
      n = { "<cmd>bn<cr>", "Next Buffer" },
      p = { "<cmd>bp<cr>", "Previous Buffer" },
      l = { "<cmd>bl<cr>", "List Buffers" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    },
    w = {
      name = "window",
      h = { "<C-w>h", "Window Left"},
      j = { "<C-w>j", "Window Down"},
      k = { "<C-w>k", "Window Up"},
      l = { "<C-w>l", "Window Right"},
      c = { "<cmd>close<cr>", "Close Window"},
      m = { "<cmd>only<cr>", "Maximise Window"},
    },
    s = {
      name = "search",
      p = { "<cmd>Telescope live_grep<cr>", "Search Project" },
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
      o = { '<cmd>Telescope projects<cr>', 'Open Project'},
    },
    l = {
      name = "lua",
      l = { "<cmd>luafile %<cr>", "Load" },
    },
    [":"] = { "<cmd>Telescope commands<cr>", "Commands" },
  }, { prefix = "<leader>" })
end

return M
