require("oil").setup({
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
    -- Constrain the cursor to the editable parts of the oil buffer
    -- Set to `false` to disable, or "name" to keep it on the file names
    constrain_cursor = "name",
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = true,
})

vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>')

-- Oil.nvim disables newrw, which disables :Browse and prevents vim-rhubarb
-- from opening github links with :GBrowse. To fix this, we just need to create
-- a custom :Browse command
vim.api.nvim_create_user_command("Browse", function(args) vim.ui.open(args.args) end, {
    desc = "Open a File/URL for browsing",
    force = true,
    nargs = 1,

})
