require('nvim-tree').setup {
	-- prefer nvim-tree over netrw for file browser
	-- disable_netrw = false,
	-- hijack_netrw = true,
}

vim.keymap.set('n', '<leader>ex', '<cmd>NvimTreeFindFile<cr>')
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>')

