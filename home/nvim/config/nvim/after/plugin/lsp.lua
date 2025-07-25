local lspconfig = require 'lspconfig'

-- Add custom server definitions not included in some versions of lspconfig
local configs = require 'lspconfig.configs'

-- protobuf LSP using Buf CLI
-- this is in beta, and some older versions of lspconfig don't support it
if not configs.buf_ls then
    configs.buf_ls = {
        default_config = {
            cmd = { 'buf', 'beta', 'lsp', '--timeout=0', '--log-format=text' },
            filetypes = { 'proto' },
            root_dir = lspconfig.util.root_pattern('buf.yaml', '.git'),
        },
    }
end

-- Configure some keybindings when a language server attaches
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local function bind(mode, keys, desc, action)
            local opts = { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, keys, action, opts)
        end
        bind("n", "K", "Show documentation of symbol under cursor in floating window (vim.lsp.buf.hover)",
            vim.lsp.buf.hover)
        bind("n", "gd", "Go to definition of symbol under cursor (vim.lsp.buf.definitions)",
            vim.lsp.buf.definition)
        bind("n", "gD", "Go to declaration of symbol under cursor (vim.lsp.buf.declarations)",
            vim.lsp.buf.declaration)
        bind("n", "gi", "Show implementations of symbol under cursor (vim.lsp.buf.implementations)",
            vim.lsp.buf.implementation)
        bind("n", "go", "Go to type definition of symbol under cursor (vim.lsp.buf.type_definition)",
            vim.lsp.buf.type_definition)
        bind("n", "gs",
            "Show signature information of symbol under cursor in floating window (vim.lsp.buf.signature_help)",
            vim.lsp.buf.signature_help)
        bind("n", "gr", "Show references to symbol under cursor in Quickfix list",
            vim.lsp.buf.references)
        bind("n", "gl", "Show diagnostics in floating window", vim.diagnostic.open_float)
        bind("n", "<leader>cr", "Rename symbol under cursor", vim.lsp.buf.rename)
        bind("n", "<leader>ca", "Show LSP code actions for current line", vim.lsp.buf.code_action)
        bind("n", "<leader>cf", "Run LSP formatting on current bufer", vim.lsp.buf.format)
        bind("n", "]d", "Go to next diagnostic", vim.diagnostic.goto_next)
        bind("n", "[d", "Go to previous diagnostic", vim.diagnostic.goto_prev)

        -- enable native LSP completion features (ex autoimport)
        -- vim.lsp.completion.enable(true, event.data.client_id, event.buf, {autotrigger = false})

        -- format buffer on save
        local client = vim.lsp.get_client_by_id(event.data.client_id);
        if client and client:supports_method("textDocument/formatting", event.buf) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format { async = false, id = event.data.client_id }
                end,
            })
        end
    end
})

local default_lsp = {
    -- Use nvim-cmp's capabilities, see `plugins/cmp.lua`
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

local language_servers = {
    marksman = {},
    bashls = {},
    taplo = {},
    ts_ls = {},
    gopls = {},
    -- legacy protobuf LSP. change to "buf_ls" to use beta Buf cli
    -- bufls = {},
    -- protobuf LSP using the beta buf CLI
    buf_ls = {},
    perlpls = {},

    -- JSON
    jsonls = {
        -- lspconfig expects "vscode-json-language-server", but nixpkgs provides it under a different name
        cmd = { "vscode-json-languageserver", "--stdio" }
    },

    -- Nix
    nixd = {
        settings = {
            ["nixd"] = {
                formatting = { command = { "nixfmt" } }
            }
        }
    },

    -- Lua
    lua_ls = {
        settings = {
            Lua = {
                telemetry = { enable = false },
                runtime = { version = "LuaJIT" },
                -- Make server aware of NeoVim runtime
                workspace = {
                    checkThirdParty = false,
                    library = vim.api.nvim_list_runtime_paths(),
                }
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
                    privateEditable = { enable = true },
                },
            }
        },
        commands = {
            ExpandMacro = {
                function()
                    local client = vim.lsp.get_clients({ name = "rust_analyzer" })[1]
                    if not client then error("rust_analyzer not found") end
                    client.request("rust-analyzer/expandMacro",
                        vim.lsp.util.make_position_params(),
                        function(err, result)
                            if err then
                                error(string.format("%s - %s", err.code, err.message))
                            end
                            local lines = vim.split(result.expansion, "\n")
                            local buf = vim.api.nvim_create_buf(true, true)
                            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                            vim.api.nvim_open_win(buf, false, { win = 0, split = "right" })
                        end)
                end
            }
        }
    },
}

for server_name, server_options in pairs(language_servers) do
    local merged = vim.tbl_deep_extend("force", default_lsp, server_options)
    lspconfig[server_name].setup(merged)
end
