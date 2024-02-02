-- load vim-compatible config
vim.cmd.source("$HOME/.vimrc")

-- set leader key for plugin keybinds
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- quickfix keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    -- jump to quickfix item without moving focus from the quickfix window location 
    vim.keymap.set('n', '<Tab>', "<CR><C-W>p", { buffer = args.buf, noremap = true })
  end
})

-- load plugins
require('plugins')

