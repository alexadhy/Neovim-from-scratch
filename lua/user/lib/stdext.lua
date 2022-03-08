--
-- Some extra batteries for fun
--
local len = function(tbl)
  local acc = 0
  for _, _ in pairs(tbl) do acc = acc + 1 end
  return acc
end

local extract = function(path)
  return function(tb)
    local acc = tb
    for _, p in ipairs(path) do acc = acc[p] end
    return acc
  end
end

local wrap_table = function(v)
  if type(v) == "table" then
    return v
  else
    return {v}
  end
end

local map = function(tbl, fn)
  local acc = {}
  for k, v in pairs(tbl) do acc[k] = fn(k, v) end
  return acc
end

local flatmap = function(tbl, fn)
  local acc = {}
  for k, v in pairs(tbl) do table.insert(acc, fn(k, v)) end
  return acc
end

local filter = function(tbl, fn)
  local acc = {}
  for k, v in pairs(tbl) do if fn(k, v) then acc[k] = v end end
  return acc
end

local reduce = function(tbl, init, fn)
  local acc = init
  for k, v in pairs(tbl) do acc = fn(acc, v, k) end
  return acc
end

local merge = function(tbls)
  local acc = {}
  for _, tb in pairs(tbls) do for key, val in pairs(tb) do acc[key] = val end end
  return acc
end

return {
  wrap_table = wrap_table,
  extract = extract,
  map = map,
  flatmap = flatmap,
  filter = filter,
  reduce = reduce,
  len = len,
  merge = merge
}
