require 'gitsigns'.setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { noremap = true, buffer = bufnr }

        vim.keymap.set('n', '<leader>gb', gs.blame_line, opts)
        vim.keymap.set('n', '<leader>gB', gs.blame, opts)
        vim.keymap.set('n', "<leader>ghs", gs.stage_hunk, opts)
        vim.keymap.set('n', "<leader>ghr", gs.reset_hunk, opts)
        vim.keymap.set('v', '<leader>ghs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
        vim.keymap.set('v', '<leader>ghr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
        vim.keymap.set('n', "<leader>ghu", gs.undo_stage_hunk, opts)
        vim.keymap.set('n', "<leader>gd", gs.diffthis, opts) -- Diff in seperate buffer
        -- vim.keymap.set('n', "<leader>gd", function()   -- Inline diff
        --     gs.toggle_deleted()
        --     gs.toggle_linehl()
        -- end, opts)
    end
}
