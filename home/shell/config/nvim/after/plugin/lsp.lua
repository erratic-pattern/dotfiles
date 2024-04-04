local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {
        'rust_analyzer',
        'bashls',
        'nil_ls',
        'lua_ls',
    },
    handlers = {
        lsp_zero.default_setup,
        -- configure lua_ls to recognize nvim globals
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        rust_analyzer = function()
            require('lspconfig').rust_analyzer.setup({
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            features = "all",
                        },
                        completion = {
                            fullFunctionSignatures = { enable = true },
                        },
                    }
                }
            })
        end
    },
})


local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
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

require('mason-nvim-dap').setup({
    ensure_installed = {
        'cppdbg',
        'codelldb',
    },
})

local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    command = vim.fn.exepath("lldb-vscode"),
    name = 'lldb'
}

local datafusion_cil = os.getenv('HOME') .. '/Code/arrow-datafusion/datafusion-cli'
local influxdb_iox = os.getenv('HOME') .. '/Code/influxdb_iox/'

dap.configurations.rust = {
    {
        name = "influxdb_iox",
        type = "lldb",
        request = "launch",
        program = function()
            return influxdb_iox .. '/target/debug/influxdb_iox'
        end,
        cwd = influxdb_iox,
        stopOnEntry = false,
        args = function()
            local langs = { 'sql', 'influxql' }
            local lang_menu = {'Select query language: '}
            for k,v in pairs(langs) do
                lang_menu[k+1] = k .. '. ' .. v
            end
            local lang_ind = vim.fn.inputlist(lang_menu)
            local lang = langs[lang_ind]
            local namespace = vim.fn.input('Namespace: ')
            local query = vim.fn.input('Query to run: ')
            return { '--lang', lang, namespace, query }
        end,
    },
    {
        name = "datafusion-cli",
        type = "lldb",
        request = "launch",
        program = function()
            return datafusion_cil .. '/target/debug/datafusion-cli'
        end,
        cwd = datafusion_cil,
        stopOnEntry = false,
        args = function()
            return { '-f', vim.fn.input('Path to SQL file: ', vim.fn.getcwd() .. '/', 'file') }
        end,
    },
}

local opts = { remap = true }
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, opts)
vim.keymap.set("n", "<leader>ds", function() dap.step_over() end, opts)
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, opts)
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, opts)
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, opts)
vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, opts)

require("dapui").setup({})
