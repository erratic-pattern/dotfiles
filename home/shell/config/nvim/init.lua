-- load vim-compatible config
vim.cmd.source("$HOME/.vimrc")

-- set leader key for plugin keybinds
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- beacon settings
vim.g.beacon_minimal_jump = 5
vim.g.beacon_ignore_filetypes = {"NvimTree", "qf"}
vim.g.beacon_shrink = 0
-- vim.g.beacon_fade = 0

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

