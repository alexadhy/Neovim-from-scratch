local bind = require('user.lib.bind')
local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end

local nmappings = {
    -- Hop.nvim
    ['s'] = ":lua require'hop'.hint_char2({current_line_only = false})<CR>",
    ['f'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<CR>",
    ['F'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>"
}

local xmappings = {
    ['f'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<CR>",
    ['F'] = ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<CR>"
}

for k, v in pairs(xmappings) do
  bind.map.x(k, v, {
    noremap = false,
    silent = true,
  })
end

for k, v in pairs(nmappings) do
  bind.map.n(k, v, {
  noremap = false,
  silent = true
})
end
