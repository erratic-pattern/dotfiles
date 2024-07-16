local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        {
            name = "buffer",
            option = {
                -- Complete from all open buffers, not only the one that is currently active
                get_bufnrs = function() return vim.api.nvim_list_bufs() end
            },
        },
    },

    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- double <leader> to trigger completion
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Navigate between cmp items
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
})

