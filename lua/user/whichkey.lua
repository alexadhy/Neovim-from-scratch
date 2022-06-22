local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	d = {
		name = "DAP",
		b = {
			"<cmd>lua require 'dap'.toggle_breakpoint()<CR>",
			"Toggle Breakpoint",
		},
		a = {
			n = {
				"<cmd>lua require 'scripts.dap'.attach_node()<CR>",
				"Attach Node",
			},
		},
		h = { "<cmd>lua require 'dap'.step_over()<CR>", "Step Over" },
		j = { "<cmd>lua require 'dap'.step_into()<CR>", "Step Into" },
		k = { "<cmd>lua require 'dap'.step_out()<CR>", "Step Out" },
		l = { "<cmd>lua require 'dap'.continue()<CR>", "Continue" },
		["?"] = {
			'<cmd>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>',
			"Scopes",
		},
		K = { '<cmd>require"dap.ui.widgets".hover()<CR>', "Hover" },
	},

	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	g = {
		name = "Git",
		g = {
			name = "gitsigns",
			d = {
				"<cmd>Gitsigns diffthis HEAD<cr>",
				"Diff",
			},
			n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			e = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
		},
		n = {
			name = "neogit",
			c = { "<cmd>Neogit commit<cr>", "Commit" },
			o = { [[<cmd>lua require'neogit'.open({ kind = "split" })<cr>]], "Open" },
		},
		o = {
			name = "octo",
			a = {
				name = "Assignee",
				a = { "<cmd>Octo assignee add<CR>", "Add" },
				r = { "<cmd>Octo assignee remove<CR>", "Remove" },
			},
			c = {
				name = "Comment",
				a = { "<cmd>Octo comment add<CR>", "Add" },
				r = { "<cmd>Octo comment delete<CR>", "Remove" },
			},
			e = {
				name = "Repo",
				f = { "<cmd>Octo repo fork<CR>", "Fork" },
				v = { "<cmd>Octo repo view<CR>", "View" },
			},
			i = {
				name = "Issue",
				b = { "<cmd>Octo issue browser<CR>", "Open issue in browser" },
				e = { "<cmd>Octo issue edit<CR>", "Edit issue" },
				l = { "<cmd>Octo issue list<CR>", "List issue" },
				n = { "<cmd>Octo issue create<CR>", "New issue" },
				r = { "<cmd>Octo issue reload<CR>", "Reload issue" },
				s = { "<cmd>Octo issue search<CR>", "Search issues" },
				u = { "<cmd>Octo issue url<CR>", "Issue URL" },
				x = { "<cmd>Octo issue close<CR>", "Close issue" },
				z = { "<cmd>Octo issue reopen<CR>", "Reopen issue" },
			},
			l = {
				name = "Label",
				a = { "<cmd>Octo label add<CR>", "Add" },
				c = { "<cmd>Octo label create<CR>", "Create" },
				r = { "<cmd>Octo label remove<CR>", "Remove" },
			},
			p = {
				name = "PR",
				b = { "<cmd>Octo pr browser<CR>", "Open PR in browser" },
				d = { "<cmd>Octo pr changes<CR>", "Diff PR changes" },
				e = { "<cmd>Octo pr edit<CR>", "Edit PR" },
				l = { "<cmd>Octo pr list<CR>", "List PR" },
				m = { "<cmd>Octo pr merge<CR>", "Merge PR" },
				n = { "<cmd>Octo pr create<CR>", "New PR" },
				o = { "<cmd>Octo pr checkout<CR>", "Checkout PR" },
				r = { "<cmd>Octo pr reload<CR>", "Reload PR" },
				s = { "<cmd>Octo pr search<CR>", "Search PRs" },
				u = { "<cmd>Octo pr url<CR>", "PR URL" },
				x = { "<cmd>Octo pr close<CR>", "Close PR" },
				z = { "<cmd>Octo pr reopen<CR>", "Reopen pr" },
			},
			r = {
				name = "Review",
				c = { "<cmd>Octo review comments<CR>", "Get comments" },
				n = { "<cmd>Octo review start<CR>", "Start review" },
				s = { "<cmd>Octo review submit<CR>", "Submit review" },
				u = { "<cmd>Octo review resume<CR>", "Resume review" },
				x = { "<cmd>Octo review discard<CR>", "Discard review" },
			},
			t = {
				name = "Reaction",
				d = { "<cmd>Octo reaction thumbs_down<CR>", "👎" },
				h = { "<cmd>Octo reaction hooray<CR>", "🎉" },
				t = { "<cmd>Octo reaction thumbs_up<CR>", "👍" },
				r = { "<cmd>Octo reaction rocket<CR>", "🚀" },
			},
		},
		s = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>TroubleToggle<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=20 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},

	["z"] = { "<cmd>ZenMode<cr>", "Zen" },
}

function set_norg_keybinds()
	which_key.register({
		n = {
			name = "Neorg",
			g = {
				name = "GTD",
				c = { "<cmd>Neorg gtd capture<cr>", "capture" },
				v = { "<cmd>Neorg gtd views<cr>", "views" },
			},
			i = { "<cmd>Neorg inject_metadata<cr>", "inject metadata" },
			p = {
				name = "Presenter",
				s = { "<cmd>Neorg presenter start<cr>", "start" },
				c = { "<cmd>Neorg presenter close<cr>", "close" },
			},
		},
	}, opts)
end
vim.cmd([[autocmd FileType norg lua set_norg_keybinds()]])

which_key.setup(setup)
which_key.register(mappings, opts)
