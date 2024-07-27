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

local function bind(mode, keys, desc, action)
    local opts = { noremap = true, desc = desc }
    vim.keymap.set(mode, keys, action, opts)
end

-- basic finders
bind('n', '<leader>f', "Search/Find Files (Telescope find_files)", function()
    builtin.find_files {
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    }
end)
bind('n', '<leader>s', "Search text in project files (Telescope live_grep)", builtin.live_grep)
bind('v', '<leader>s', "Search selected text in project files (Telescope grep_string)", builtin.grep_string)
bind('n', '<leader>b', "Search open buffers (Telescope buffers)", builtin.buffers)
bind('n', '<leader>h', "Search :help tags (Telescope help_tags)", builtin.help_tags)
bind('n', '<leader>r', "Resume previous telescope finder (Telescpe resume)", builtin.resume)
bind('n', '<leader>?', "Search key mappings (Telescope keymaps)", builtin.keymaps)
bind('n', '<leader>x', "Search Telescope Pickers (Telescope builtin)", builtin.builtin)
-- git finders
bind('n', '<leader>vf', "Search Git files (Telescope git_files)", builtin.git_files)
bind('n', '<leader>vc', "Search Git commits (Telescope git_commits)", builtin.git_commits)
bind('n', '<leader>vb', "Search Git branches (Telescope git_branches)", builtin.git_branches)
bind('n', '<leader>vs', "Search Git staged changes (Telescope git_status)", builtin.git_status)
bind('n', '<leader>vx', "Search Git stash (Telescope git_stash)", builtin.git_stash)
-- LSP finders
bind('n', '<leader>gr', "Search LSP references (Telescope lsp_references)", builtin.lsp_references)
bind('n', '<leader>gi', "Search LSP implementations (Telescope lsp_implementations)", builtin.lsp_implementations)
bind('n', '<leader>gd', "Search LSP definitions (Telescope lsp_defintions)", builtin.lsp_definitions)
bind('n', '<leader>go', "Search LSP type defintions (Telescope lsp_type_definitions)", builtin.lsp_type_definitions)
bind('n', '<leader>lic', "Search LSP incoming calls (Telescope lsp_incoming_calls)", builtin.lsp_incoming_calls)
bind('n', '<leader>loc', "Search LSP outgoing calls (Telescope lsp_outgoing_calls)", builtin.lsp_outgoing_calls)
bind('n', '<leader>gl', "Search diagnostics (Telescope diagnostics)", builtin.diagnostics)
bind('n', '<leader>lsb', "Search LSP document symbols (Telescope lsp_document_symbols)", builtin.lsp_document_symbols)
bind('n', '<leader>lsw', "Search LSP workspace symbols (Telescope lsp_workspace_symbols)", builtin.lsp_workspace_symbols)

