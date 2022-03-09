neorg_ok, neorg = pcall(require, "neorg")
if not neorg_ok then
  return
end

neorg.setup {
        -- Tell Neorg what modules to load
        load = {
          ["core.defaults"] = {}, -- Load all the default modules
          ["core.keybinds"] = { -- Configure core.keybinds
            config = {
              default_keybinds = true, -- Generate the default keybinds
              neorg_leader = "<Leader>o", -- This is the default if unspecified
            },
          },
          ["core.norg.concealer"] = {}, -- Allows for use of icons
          ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                my_workspace = "~/Documents/norg",
              },
            },
          },
          ["core.gtd.base"] = {
            config = {
              workspace = "my_workspace",
            }
          },
          ["core.gtd.queries"] = {},
          ["core.gtd.ui"] = {},
          ["core.queries.native"] = {},
          ["core.norg.completion"] = {
            config = {
              engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
            },
          },
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
            },
          },
          ["core.integrations.telescope"] = {},
        },
}
