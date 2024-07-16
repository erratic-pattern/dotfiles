require('nvim-tree').setup {
	disable_netrw = false,
}

vim.keymap.set('n', '<leader>ex', '<cmd>NvimTreeFindFile<cr>')
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>')

