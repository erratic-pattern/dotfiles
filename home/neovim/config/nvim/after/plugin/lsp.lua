-- Configure some keybindings when a language server attaches
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local function bind(mode, keys, desc, action)
            local opts = { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, keys, action, opts)
        end
        bind("n", "K", "Show documentation of symbol under cursor in floating window (vim.lsp.buf.hover)",
            function() vim.lsp.buf.hover() end)
        bind("n", "gd", "Go to definition of symbol under cursor (vim.lsp.buf.definitions)",
            function() vim.lsp.buf.definition() end)
        bind("n", "gD", "Go to declaration of symbol under cursor (vim.lsp.buf.declarations)",
            function() vim.lsp.buf.declaration() end)
        bind("n", "gi", "Show implementations of symbol under cursor (vim.lsp.buf.implementations)",
            function() vim.lsp.buf.implementation() end)
        bind("n", "go", "Go to type definition of symbol under cursor (vim.lsp.buf.type_definition)",
            function() vim.lsp.buf.type_definition() end)
        bind("n", "gs",
            "Show signature information of symbol under cursor in floating window (vim.lsp.buf.signature_help)",
            function() vim.lsp.buf.signature_help() end)
        bind("n", "gr", "Show references to symbol under cursor in Quickfix list",
            function() vim.lsp.buf.references() end)
        bind("n", "gl", "Show diagnostics in floating window", function() vim.diagnostic.open_float() end)
        bind("n", "<leader>cr", "Rename symbol under cursor", function() vim.lsp.buf.rename() end)
        bind("n", "<leader>ca", "Show LSP code actions for current line", function() vim.lsp.buf.code_action() end)
        bind("n", "<leader>cf", "Run LSP formatting on current bufer", function() vim.lsp.buf.format() end)
        bind("n", "]d", "Go to next diagnostic", function() vim.diagnostic.goto_next() end)
        bind("n", "[d", "Go to previous diagnostic", function() vim.diagnostic.goto_prev() end)
    end
})

local default_lsp = {
    -- Use nvim-cmp's capabilities, see `plugins/cmp.lua`
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

-- require('mason').setup({})
local language_servers = {
    bashls = {},
    taplo = {},
    tsserver = {},
    gopls = {},

    -- JSON
    jsonls = {
        -- lspconfig expects "vscode-json-language-server", but nixpkgs provides it under a different name
        cmd = { "vscode-json-languageserver", "--stdio" }
    },

    -- Nix
    nil_ls = {
        settings = {
            ["nil"] = {
                formatting = { command = { "nixpkgs-fmt" } }
            }
        }
    },

    -- Lua
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                runtime = { version = "LuaJIT" },
                telemetry = { enable = false }
            }
        }
    },

    -- Python
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = {
                            -- "E201", -- Whitespace after opening bracket
                            -- "E202", -- Whitespace before closing bracket
                            -- "E302", -- Two newlines after imports
                            -- "E305", -- Two newlines after class/function
                            -- "E501", -- Line too long
                        }
                    }
                }
            }
        }
    },

    -- YAML
    yamlls = {
        settings = {
            redhat = {
                telemetry = { enabled = false }
            }
        }
    },

    rust_analyzer = {
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
    },
}

for server_name, server_options in pairs(language_servers) do
    local merged = vim.tbl_deep_extend("force", default_lsp, server_options)
    require("lspconfig")[server_name].setup(merged)
end
