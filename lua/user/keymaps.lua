local bind = require('user.lib.bind')

local opts = {
  noremap = true,
  silent = true
}

local term_opts = {
  silent = true
}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal mappings
local normal_mappings = {
  -- Clipboard
  ['Y'] = 'y$', -- copy to end of line
  -- Indentation
  ['<'] = '<<',
  ['>'] = '>>',
  -- Space to Tab
  ['<LEADER>tt'] = ':%s/    /\t/g'
}

local global_mappings = {
  -- Quit
  ['Q'] = ':q<CR>',
  -- Open vimrc
  ['<LEADER>rc'] = ':e ~/.config/nvim/init.vim<CR>',
  ['<LEADER>rn'] = ':e ~/Notes/index.md<CR>',
  ['l'] = 'i',
  ['L'] = 'I',
  -- Search
  ['<LEADER><CR>'] = ':set hls! | set hls?<CR>',
  -- Open gitui (Rust alternative to lazygit, great)
  ['<LEADER>gg'] = ':tabe<CR>:-tabmove<CR>:term gitui<CR>',
  -- ==
  -- == Cursor Movement (Colemak hnei)
  -- ==
  --     ^
  --     e
  -- < h   i >
  --     n
  --     v
  ['e'] = 'k',
  ['n'] = 'j',
  ['i'] = 'l',
  ['k'] = 'n',
  ['ge'] = 'gk',
  ['gn'] = 'gj',
  ['E'] = '5k',
  ['N'] = '5j',
  ['H'] = '0', -- H -> go to start of line
  ['I'] = '$', -- I -> go to end of line
  ['W'] = '5w',
  ['B'] = '5b',
  ['<C-E>'] = '5<C-y>', -- move up page
  ['<C-N>'] = '5<C-e>', -- move down page
  --        ==
  -- == Window management
  -- ==
  -- Use <space> + new arrow keys for moving the cursor around windows
  ['<LEADER>ww'] = '<C-w>w',
  ['<LEADER>we'] = '<C-w>k',
  ['<LEADER>wn'] = '<C-w>j',
  ['<LEADER>wh'] = '<C-w>h',
  ['<LEADER>wi'] = '<C-w>l',
  -- Disable the default s key
  -- ['s'] = '<nop>'},
  -- split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
  ['<LEADER>se'] = ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>',
  ['<LEADER>sn'] = ':set splitbelow<CR>:split<CR>',
  ['<LEADER>sh'] = ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>',
  ['<LEADER>si'] = ':set splitright<CR>:vsplit<CR>',
  -- Resize splits with arrow keys
  ['<Leader>w<up>'] = ':res +5<CR>',
  ['<Leader><down>'] = ':res -5<CR>',
  ['<Leader><left>'] = ':vertical resize-5<CR>',
  ['<Leader><right'] = ':vertical resize+5<CR>',
  ['<LEADER>ss'] = '<C-w>t<C-w>K', -- Place the two screens up and down
  ['<LEADER>sv'] = '<C-w>t<C-w>H', -- Place the two screens side by side
  ['<LEADER>srh'] = '<C-w>b<C-w>K', -- Rotate screens
  ['<LEADER>srv'] = '<C-w>b<C-w>H',
  ['<LEADER>bq'] = '<C-w>j:q<CR> ', -- Press <SPACE> + q to close the window below the current window
  -- ==
  -- == Tab management
  -- ==
  ['<LEADER>tn'] = ':tabe<CR>',
  ['<LEADER>th'] = ':-tabnext<CR>',
  ['<LEADER>ti'] = ':+tabnext<CR>',
  ['<LEADER>tmh'] = ':-tabmove<CR>',
  ['<LEADER>tmi'] = ':+tabmove<CR>',
  -- Opening a terminal window
  ["<LEADER>'"] = ':set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>',
  -- Spelling Check with <space>sc
  ['<LEADER>msc'] = ':set spell!<CR>',
  -- Press ` to change case (instead of ~)
  ['`'] = '~',
  ['<C-c>'] = 'zz',
  ['<LEADER>-'] = ':lN<CR>',
  ['<LEADER>='] = ':lne<CR>',
  -- find and replace
  ['<LEADER>rf'] = ':%s//g<left><left>'
}

local terminal_mappings = {
  -- Terminal behavior
  ['t<C-N>'] = '<C-\\><C-N>',
  ['t<C-O>'] = '<C-\\><C-N><C-O>'
}

local command_mappings = {
  -- Command mode cursor movement
  ['<C-a>'] = '<Home>',
  ['<C-e>'] = '<End>',
  ['<C-p>'] = '<Up>',
  ['<C-n>'] = '<Down>',
  ['<C-b>'] = '<Left>',
  ['<C-f>'] = '<Right>',
  ['<M-b>'] = '<S-Left>',
  ['<M-w>'] = '<S-Right>'
}

local bind_allmodes = function()
  for k, v in pairs(global_mappings) do
    bind.map.nov(k, v, {
      noremap = true
    })
  end
end

local bind_normals = function()
  for k, v in pairs(normal_mappings) do
    bind.map.n(k, v, {
      noremap = true
    })
  end
end

local bind_inserts = function()
  bind.map.i('<C-a>', '<ESC>H', {
    noremap = true
  })
  bind.map.i('<C-e>', '<ESC>I', {
    noremap = true
  })
  -- Move next character to the end of the line with ctrl+u
  bind.map.i('<C-u>', '<ESC>lx$p', {
    noremap = true
  })
end

local bind_terminals = function()
  for k, v in pairs(terminal_mappings) do
    bind.map.t(k, v, {
      noremap = true
    })
  end
end

local bind_commands = function()
  for k, v in pairs(command_mappings) do
    bind.map.c(k, v, {
      noremap = true
    })
  end
end

bind_allmodes()
bind_normals()
bind_inserts()
bind_terminals()
bind_commands()

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-n>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-e>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "kk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-n>", ":m .+1<CR>==", opts)
keymap("v", "<A-e>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "N", ":move '>+1<CR>gv-gv", opts)
keymap("x", "E", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-n>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-e>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-n>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-e>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-i>", "<C-\\><C-N><C-w>l", term_opts)
