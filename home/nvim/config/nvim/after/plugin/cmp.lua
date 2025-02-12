local cmp = require('cmp')
local cmp_buffer = require("cmp_buffer")

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
        -- key to confirm completion
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        -- manually open completion
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            -- Sort buffer completion items by distance from the cursor
            function(...) return cmp_buffer:compare_locality(...) end,
            cmp.config.compare.kind,
        }
    },
})

-- Autocomplete git/github issues, PRs, usernames, and commits
require("cmp_git").setup()
cmp.setup.filetype({'gitcommit', 'octo'}, {
    sources = cmp.config.sources({
        { name = 'git' },
        { name = 'buffer' },
    })
})

-- Use the cmp completion menu for searching through the current buffer
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use the cmp completion menu when entering vim commands
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    })
})
