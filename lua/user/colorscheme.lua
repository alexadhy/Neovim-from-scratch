vim.cmd [[
try
  colorscheme tokyonight
"  colorscheme kanagawa
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
