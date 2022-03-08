require("dap.repl").commands = vim.tbl_extend("force", require("dap.repl").commands, {
    continue = { ".continue", "c" },
    next_ = { ".next", "n" },
    into = { ".into", "s" },
    into_targets = { "st" },
    out = { ".out", "r" },
    scopes = { ".scopes", "a" },
    threads = { ".threads", "t", "threads" },
    frames = { ".frames", "f", "bt" },
    exit = { "exit", ".exit", "q" },
    up = { ".up", "up" },
    down = { ".down", "down" },
    goto_ = { ".goto", "j" },
    capabilities = { ".capabilities", ".ca" },
    custom_commands = {
      [".echo"] = function(text)
        dap.repl.append(text)
      end,
    },
  })

