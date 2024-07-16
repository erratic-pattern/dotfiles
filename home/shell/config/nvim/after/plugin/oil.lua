require("oil").setup()

vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>')

-- Oil.nvim disables newrw, which disables :Browse and prevents vim-rhubarb
-- from opening github links with :GBrowse. To fix this, we just need to create
-- a custom :Browse command
vim.api.nvim_create_user_command("Browse", function(args) vim.ui.open(args.args) end, {
    desc = "Open a File/URL for browsing",
    force = true,
    nargs = 1,
})
