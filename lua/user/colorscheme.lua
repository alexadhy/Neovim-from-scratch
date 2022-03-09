vim.cmd [[
try
"   colorscheme nord
  colorscheme moonlight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
