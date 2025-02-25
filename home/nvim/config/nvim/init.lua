-- load vim-compatible config
vim.cmd.source("$HOME/.vimrc")

-- set leader key for plugin keybinds
vim.keymap.set("n", "<Space>", "<Nop>", { desc = "Leader key" })
vim.g.mapleader = " "

-- don't show mode since it's already in statusline
vim.opt.showmode = false

-- disable smartindent and enable treesitter indent
vim.opt.smartindent = false
vim.treesitter.indent = true

-- Quickfix Open/Close mappings
vim.keymap.set('n', '<leader>q', '<cmd>belowright copen<CR>', { desc = 'Open Quickfix Window' })
vim.keymap.set('n', '<leader>Q', '<cmd>belowright cclose<CR>', { desc = 'Close Quickfix Window' })

-- Toggle relative line numbers
vim.keymap.set('n', '<leader>ln', '<cmd>set invrelativenumber<CR>', { desc = "Toggle relative line numbers" })

-- quickfix keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    -- jump to quickfix item without moving focus from the quickfix window location
    vim.keymap.set('n', '<Tab>', "<CR>:copen<CR>", { buffer = args.buf, noremap = true, desc = "Preview Quickfix Item" })
  end
})

-- highlight on yank
vim.cmd [[
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='Visual', timeout=150}
]]

-- load tintin setup
require('tintin')
