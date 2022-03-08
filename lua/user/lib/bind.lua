--
-- Bind utility
--
local api = vim.api
local stdext = require('user.lib.stdext')

local map = function()
  local base = {
    silent = true
  }
  local partial = function(prefix)
    return function(lhs, rhs, opt)
      local rhs = rhs or ""
      local opt = opt or {}
      local options = stdext.merge {base, opt}
      if options.buffer then
        local buf = options.buffer
        options.buffer = nil
        for _, mode in ipairs(prefix) do
          api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
        end
      else
        for _, mode in ipairs(prefix) do
          api.nvim_set_keymap(mode, lhs, rhs, options)
        end
      end
    end
  end

  return {
    n = partial {"n"},
    x = partial {"x"},
    c = partial {"c"},
    v = partial {"v"},
    i = partial {"i"},
    r = partial {"r"},
    op = partial {"o"},
    t = partial {"t"},
    no = partial {"n", "o"},
    nv = partial {"n", "v"},
    ni = partial {"n", "i"},
    nov = partial {"n", "o", "v"}
  }
end

return {
  map = map()
}
