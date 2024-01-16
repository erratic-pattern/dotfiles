vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- fuzzy finder/picker
    use {
        'nvim-telescope/telescope.nvim', tag = "0.1.5",
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-ui-select.nvim' }


    -- file explorers/browsers
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    -- smooth scrolling
    use {
        'declancm/cinnamon.nvim',
        config = function() require('cinnamon').setup({
            default_delay = 3, 
        }) end
    }

    -- LSP config
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Installation
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            -- LSP Integration/Config
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

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
    use 'tpope/vim-surround' -- surround text with brackets, quotes, etc.
    use 'mbbill/undotree'
    -- use 'HiPhish/nvim-ts-rainbow2' -- bracket highlighting
    use 'yamatsum/nvim-cursorline' -- underline word under cursor
    use 'lukas-reineke/indent-blankline.nvim' -- indentation guides

    -- git integrations
    use {
        'lewis6991/gitsigns.nvim', -- git signs in gutter
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'tpope/vim-fugitive' -- git commands
    use 'tpope/vim-rhubarb' -- open GitHub links at cursor

    -- gist integration
    use {
        "rawnly/gist.nvim",
        config = function() require("gist").setup() end,
        -- `GistsList` opens the selected gif in a terminal buffer,
        -- this plugin uses neovim remote rpc functionality to open the gist in an actual buffer and not have buffer inception
        requires = { "samjwill/nvim-unception", setup = function() vim.g.unception_block_while_host_edits = true end }
    }

    -- language-specific plugins
    use 'LnL7/vim-nix' -- nix language support

    -- AI overlords
    use 'github/copilot.vim'

    -- colorschemes
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                variant = 'moon',
                -- bold_vert_split = true,
                -- dim_nc_background = true,
                -- disable_background = true,
                -- disable_float_background = true,
                -- disable_italics = true,
            })
            -- vim.cmd [[colorscheme rose-pine]]
        end
    }
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

