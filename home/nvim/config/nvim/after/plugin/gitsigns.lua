require 'gitsigns'.setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function bind(mode, keys, desc, action)
            local opts = { noremap = true, buffer = bufnr, desc = desc }
            vim.keymap.set(mode, '<leader>' .. keys, action, opts)
        end
        bind('n', 'gb', "Show line blame in floating window", gs.blame_line)
        bind('n', 'gB', "Show file blame in split window", gs.blame)
        bind('n', 'ghs', "Git stage hunk", gs.stage_hunk)
        bind('n', 'ghr', "Git reset hunk", gs.reset_hunk)
        bind('v', 'ghs', "Git stage selected hunk", function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        bind('v', 'ghr', "Git reset selected hunk", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        bind('n', 'ghu', "Git undo previously staged hunk", gs.undo_stage_hunk)
        bind('n', 'gd', "Git diff in separate buffer", gs.diffthis) -- Diff in seperate buffer
        -- vim.keymap.set('n', "<leader>gd", function()   -- Inline diff
        --     gs.toggle_deleted()
        --     gs.toggle_linehl()
        -- end, opts)
    end
}
