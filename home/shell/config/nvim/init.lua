-- load vim-compatible config
vim.cmd.source("$HOME/.vimrc")

-- set leader key for plugin keybinds
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- don't show mode since it's already in statusline
vim.opt.showmode = false

-- beacon settings
vim.g.beacon_minimal_jump = 5
vim.g.beacon_ignore_filetypes = {"NvimTree", "qf"}
vim.g.beacon_size = 80
-- vim.g.beacon_shrink = 0
-- vim.g.beacon_fade = 0

-- quickfix keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    -- jump to quickfix item without moving focus from the quickfix window location 
    vim.keymap.set('n', '<Tab>', "<CR><C-W>p", { buffer = args.buf, noremap = true })
  end
})

-- add FileType for TinTin++ command files 
vim.filetype.add({
  extension = {
    tt = "tt",
    tin = "tt"
  },
})

-- load syntax file for TinTin++ command files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tt",
  command = [[
    runtime syntax/tt.vim
    setlocal nosmartindent
    setlocal commentstring=#nop\ %s
  ]],
})

-- load plugins
require('plugins')

