dap_install_ok, dap_install = pcall(require, "dap-install")
if not dap_install_ok then
  return
end

local setup = function()
  local dbg_list = {"go_delve", "codelldb"}

  for _, debugger in ipairs(dbg_list) do
    dap_install.config(debugger)
  end
end

setup()
