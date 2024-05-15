local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.format_on_save({
    servers = {
        ['lua_ls'] = { 'lua' },
        ['gopls'] = { 'go' },
        ['bashls'] = { 'sh' },
        ['bufls'] = { 'proto' },
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp.cmp_format({ details = false }),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
--
-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
local lsp_config = require("lspconfig")
local util = require("lspconfig/util")

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "tsserver", "rust_analyzer", "gopls", "bashls",
        "bufls", "lua_ls", "pylsp",
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            lsp_config.lua_ls.setup(lua_opts)
        end,
        gopls = function()
            lsp_config.gopls.setup({
                on_attach = lsp.on_attach,
                capabilities = lsp.capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.mod", ".git", "go.work"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        semanticTokens = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        syntax = {
                            check = true,
                            diagnostics = true,
                        },
                        gofumpt = true,
                        staticcheck = true,
                    }
                }
            })
        end,
        pylsp = function()
            lsp_config.pylsp.setup({
                on_attach = lsp.on_attach,
                capabilities = lsp.capabilities,
                cmd = { "pylsp" },
                filetypes = { "python" },
                root_dir = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = { enabled = false },
                            pydocstyle = { enabled = false },
                            pylint = { enabled = false },
                            flake8 = { enabled = false },
                            yapf = { enabled = false },
                            autopep8 = { enabled = false },
                            mypy = { enabled = false },
                            isort = { enabled = false },
                            jedi = { enabled = false },
                            mccabe = { enabled = false },
                            pyflakes = { enabled = false },
                            rope = { enabled = false },
                            pyls_isort = { enabled = true },
                            pyls_black = { enabled = true },
                            pyls_mypy = { enabled = true },
                        }
                    }
                }
            })
        end,
    }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
