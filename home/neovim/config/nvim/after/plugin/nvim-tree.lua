require('nvim-tree').setup {
	disable_netrw = false,
}

vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeFindFileToggle<cr>',
	{ noremap = true, desc = "Open file tree on current file (NvimTreeFindFileToggle)" })
