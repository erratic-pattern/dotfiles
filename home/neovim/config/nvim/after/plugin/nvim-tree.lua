require('nvim-tree').setup {
	disable_netrw = false,
}

vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeFindFile<cr>',
	{ noremap = true, desc = "Open file tree on current file (NvimTreeFindFile)" })

vim.keymap.set('n', '<leader>T', '<cmd>NvimTreeToggle<cr>',
	{ noremap = true, desc = "Open/close file tree (NvimTreeToggle)" })
