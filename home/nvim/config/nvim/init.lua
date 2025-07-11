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

-- Quickfix mappings
vim.keymap.set('n', '<leader>qo', '<cmd>belowright copen<CR>', { desc = 'Open Quickfix Window' })
vim.keymap.set('n', '<leader>qc', '<cmd>belowright cclose<CR>', { desc = 'Close Quickfix Window' })
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<CR>', { desc = 'Next Quickfix Item' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<CR>', { desc = 'Previous Quickfix Item' })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    -- jump to quickfix item without moving focus from the quickfix window location
    vim.keymap.set('n', '<Tab>', "<CR>:copen<CR>", { buffer = args.buf, noremap = true, desc = "Preview Quickfix Item" })
  end
})

-- Move visual selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Sane terminal mode escape
vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-N>", { desc = "Escape Terminal Mode" })

-- highlight on yank
vim.cmd [[
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='Visual', timeout=150}
]]

