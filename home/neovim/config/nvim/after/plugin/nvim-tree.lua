require('nvim-tree').setup {
	disable_netrw = false,
}

vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeFindFileToggle<cr>')

