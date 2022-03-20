local status_ok, octo = pcall(require, "octo")
if not status_ok then
	return
end

octo.setup({
	default_remote = { "upstream", "origin", "backup" }, -- order to try remotes
	reaction_viewer_hint_icon = "", -- marker for user reactions
	user_icon = " ", -- user icon
	timeline_marker = "", -- timeline marker
	timeline_indent = "2", -- timeline indentation
	right_bubble_delimiter = "", -- Bubble delimiter
	left_bubble_delimiter = "", -- Bubble delimiter
	snippet_context_lines = 4, -- number or lines around commented lines
	file_panel = {
		size = 10, -- changed files panel rows
		use_icons = true, -- use web-devicons in file panel
	},
	mappings = {
		issue = {
			next_comment = "]c", -- go to next comment
			prev_comment = "[c", -- go to previous comment
		},
		pull_request = {
			next_comment = "]c", -- go to next comment
			prev_comment = "[c", -- go to previous comment
		},
		review_thread = {
			next_comment = "]c", -- go to next comment
			prev_comment = "[c", -- go to previous comment
			select_next_entry = "]q", -- move to previous changed file
			select_prev_entry = "[q", -- move to next changed file
			close_review_tab = "<C-g>x", -- close review tab
		},
		submit_win = {
			approve_review = "<C-g>a", -- approve review
			comment_review = "<C-g>c", -- comment review
			request_changes = "<C-g>r", -- request changes review
			close_review_tab = "<C-g>x", -- close review tab
		},
		-- review_diff = {
		--   add_review_comment = ",ca",    -- add a new review comment
		--   add_review_suggestion = ",sa", -- add a new review suggestion
		--   focus_files = "<C-g>e",           -- move focus to changed file panel
		--   toggle_files = "<C-g>b",          -- hide/show changed files panel
		--   next_thread = "]t",                  -- move to next thread
		--   prev_thread = "[t",                  -- move to previous thread
		--   select_next_entry = "]q",            -- move to previous changed file
		--   select_prev_entry = "[q",            -- move to next changed file
		--   close_review_tab = "<C-c>",          -- close review tab
		--   toggle_viewed = "<C-g>,",   -- toggle viewer viewed state
		-- },
		file_panel = {
		  next_entry = "n",                    -- move to next changed file
		  prev_entry = "e",                    -- move to previous changed file
		  select_entry = "<cr>",               -- show selected changed file diffs
		  refresh_files = "R",                 -- refresh changed files panel
		  focus_files = "<C-g>e",           -- move focus to changed file panel
		  toggle_files = "<C-g>b",          -- hide/show changed files panel
		  select_next_entry = "]q",            -- move to previous changed file
		  select_prev_entry = "[q",            -- move to next changed file
		  close_review_tab = "<C-c>",          -- close review tab
		  toggle_viewed = "<C-g>,",   -- toggle viewer viewed state
		}
	},
})
