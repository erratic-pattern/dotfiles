-- Configure some keybindings when a language server attaches
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
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
