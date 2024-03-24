vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'nvim-tree/nvim-web-devicons'
    -- status line
    use 'nvim-lualine/lualine.nvim'

    -- fuzzy finder/picker
    use {
        'nvim-telescope/telescope.nvim', tag = "0.1.5",
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'


    -- file explorers/browsers
    use 'nvim-tree/nvim-tree.lua'

    -- UX improvement plugins
    use 'danilamihailov/beacon.nvim'
    use 'tpope/vim-sleuth' -- autoconfigure indent

    -- LSP config
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Installation
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- LSP Integration/Config
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    -- debugger config
    use { "nvim-neotest/nvim-nio" }
    use 'mfussenegger/nvim-dap'
    use 'jay-babu/mason-nvim-dap.nvim'
    use 'rcarriga/nvim-dap-ui'

    -- treesitter for parsing and highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = { "nvim-treesitter/nvim-treesitter-textobjects", },
    }

    -- editing helper plugins
    use {
        "numToStr/Comment.nvim", -- comment lines
        config = function()
            require('Comment').setup()
        end
    }
    use 'mbbill/undotree'
    -- use 'HiPhish/nvim-ts-rainbow2' -- bracket highlighting

    -- git integrations
    use {
        'lewis6991/gitsigns.nvim', -- git signs in gutter
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'tpope/vim-fugitive' -- git commands
    use 'tpope/vim-rhubarb'  -- open GitHub links at cursor

    -- gist integration
    use {
        "rawnly/gist.nvim",
        config = function() require("gist").setup() end,
        -- `GistsList` opens the selected gif in a terminal buffer,
        -- this plugin uses neovim remote rpc functionality to open the gist in an actual buffer and not have buffer inception
        requires = { "samjwill/nvim-unception", setup = function() vim.g.unception_block_while_host_edits = true end }
    }

    -- github integration
    use {
        'pwntester/octo.nvim',
        config = function()
            require "octo".setup()
        end
    }

    -- AI overlords
    use 'github/copilot.vim'

    -- colorschemes
    use {
        'folke/tokyonight.nvim',
        config = function()
            require("tokyonight").setup {
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark",
                    floats = "dark",
                },
                lualine_bold = true,
            }
            vim.cmd [[colorscheme tokyonight-moon]]
        end
    }
end)
