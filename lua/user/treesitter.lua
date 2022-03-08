local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

configs.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = {""}, -- List of parsers to ignore installing
  autopairs = {
    enable = true
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {""}, -- list of language that will be disabled
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true,
    disable = {"yaml"}
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  },
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = '<enter>', -- maps in normal mode to init the node/scope selection
      node_incremental = 'grn', -- increment to the upper named parent
      scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
      node_decremental = 'grm'
    }
  },
  textobjects = { -- syntax-aware textobjects
    -- lsp_interop = {
    -- enable = true,
    -- peek_definition_code = {
    -- ["df"] = "@function.outer",
    -- ["dF"] = "@class.outer",
    -- },
    -- },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer"
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer"
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer"
      }
    },
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['ae'] = '@block.outer',
        ['ie'] = '@block.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['is'] = '@statement.inner',
        ['as'] = '@statement.outer',
        ['ad'] = '@comment.outer',
        ['am'] = '@call.outer',
        ['im'] = '@call.inner'
      }
    }
  }
}
