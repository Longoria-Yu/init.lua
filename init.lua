local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = "\\"      -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.6',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    -- { "ellisonleao/gruvbox.nvim" },
    -- { 'folke/tokyonight.nvim' },
    {
        'rose-pine/neovim',
        lazy = false,
        name = 'rose-pine'
    },

    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").init {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },

    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    "ThePrimeagen/harpoon",
    "ThePrimeagen/refactoring.nvim",
    "mbbill/undotree",
    "tpope/vim-fugitive",

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required

            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    },

    "github/copilot.vim",
    "eandrju/cellular-automaton.nvim",
    "laytan/cloak.nvim",

    { "fatih/vim-go", build = ':GoUpdateBinaries' },
    {
        "akinsho/bufferline.nvim",
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons'
    }
})

require("longoria")
