require('nvim-tree').setup {
	-- prefer nvim-tree over netrw for file browser
	disable_netrw = false,
	hijack_netrw = true,
}

-- require'nvim-web-devicons'.setup { }

vim.keymap.set('n', '<leader>ex', '<cmd>NvimTreeFindFile<cr>')
vim.keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>')

