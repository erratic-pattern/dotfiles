local telescope = require 'telescope'

telescope.setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        }
    }
})

telescope.load_extension "ui-select"

local builtin = require('telescope.builtin')


-- basic finders
vim.keymap.set('n', '<leader>f', function()
    builtin.find_files {
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    }
end)
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('v', '<leader>s', builtin.grep_string, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>r', builtin.resume, {})
-- git finders
vim.keymap.set('n', '<leader>vf', builtin.git_files, {})
vim.keymap.set('n', '<leader>vc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>vb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>vs', builtin.git_status, {})
vim.keymap.set('n', '<leader>vx', builtin.git_stash, {})
-- LSP finders
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>go', builtin.lsp_type_definitions, {})
vim.keymap.set('n', '<leader>gl', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>lsb', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>lsw', builtin.lsp_workspace_symbols, {})
