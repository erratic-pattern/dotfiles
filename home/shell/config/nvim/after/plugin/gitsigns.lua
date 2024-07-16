require 'gitsigns'.setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { noremap = true, buffer = bufnr }

        vim.keymap.set('n', '<leader>gsb', gs.toggle_current_line_blame, opts)
        vim.keymap.set('n', '<leader>gsB', gs.blame, opts)
        vim.keymap.set('n', "<leader>gss", gs.stage_hunk, opts)
        vim.keymap.set('n', "<leader>gsr", gs.reset_hunk, opts)
        vim.keymap.set('n', "<leader>gsS", gs.stage_buffer, opts)
        vim.keymap.set('v', '<leader>gss', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
        vim.keymap.set('v', '<leader>gsr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
        vim.keymap.set('n', "<leader>gsu", gs.undo_stage_hunk, opts)
        vim.keymap.set('n', "<leader>gsd", gs.diffthis, opts) -- Diff in seperate buffer
        -- vim.keymap.set('n', "<leader>gsd", function()   -- Inline diff
        --     gs.toggle_deleted()
        --     gs.toggle_linehl()
        -- end, opts)
    end
}
