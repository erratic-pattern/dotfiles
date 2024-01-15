require('nvim-tree').setup { }
-- require'nvim-web-devicons'.setup { }

vim.keymap.set('n', '<leader>ex', '<cmd>NvimTreeFindFile<cr>')
vim.keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>')

