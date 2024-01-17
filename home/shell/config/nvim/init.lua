-- load vim-compatible config
vim.cmd.source("$HOME/.vimrc")

-- set leader key for plugin keybinds
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- load plugins
require('plugins')

