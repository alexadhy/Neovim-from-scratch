local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local diff = {
	"diff",
	colored = false,
	symbols = { added = "  ", modified = " ", removed = " " },
	cond = hide_in_width,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local mode = function ()
  return " "
end

require("lualine").setup({
	options = {
		component_separators = "|",
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			{ mode, separator = { left = "" }, right_padding = 2 },
		},
		lualine_b = { "filename", "branch" },
		lualine_c = { diagnostics },
		lualine_x = {},
		lualine_y = { "filetype", diff },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})

