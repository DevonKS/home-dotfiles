local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
  -- diagnostics_color = {
  --   -- Same values like general color option can be used here.
  --   error = 'DiagnosticError', -- changes diagnostic's error color
  --   warn  = 'DiagnosticWarn',  -- changes diagnostic's warn color
  --   info  = 'DiagnosticInfo',  -- changes diagnostic's info color
  --   hint  = 'DiagnosticHint',  -- changes diagnostic's hint color
  -- },
	symbols = { error = " ", warn = " ", hint = " ", info = " " },
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local fileformat = {
  'fileformat',
  symbols = {
    unix = '', -- e712
    dos = '', -- e70f
    mac = '', -- e711
  }
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch, diagnostics },
    lualine_c = {'filename'},
		lualine_x = { diff, "encoding", fileformat, "filetype" },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
