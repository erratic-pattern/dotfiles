require("gitsigns").setup()
-- require("gist").setup()
require("octo").setup()

vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns blame_line<cr>')
