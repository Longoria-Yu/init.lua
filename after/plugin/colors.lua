require("rose-pine").setup({
    --- @usage 'main'|'moon'|'dawn'
    dark_variant = 'moon',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = true,
    disable_float_background = false,
    disable_italics = false,
    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true,        -- Handle deprecated options automatically
    },
    --- @usage string hex value or named color from rosepinetheme.com/palette
    groups = {
        background = 'base',
        background_nc = '_experimental_nc',
        panel = 'surface',
        panel_nc = 'base',
        border = 'highlight_med',
        comment = 'muted',
        link = 'iris',
        punctuation = 'subtle',
        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',
        headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
        }
        -- or set all headings at once
        -- headings = 'subtle'
    },
    -- Change specific vim highlight groups
    -- https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua
    highlight_groups = {
        ColorColumn               = { bg = 'rose' },

        --- Functions
        Function                  = { fg = 'yellow' },
        ["@function"]             = { fg = 'yellow' },
        ["@function.builtin"]     = { fg = 'yellow', bold = true },
        -- ["@function.call"] = {},
        ["@function.macro"]       = { link = "Function" },
        ["@function.method"]      = { fg = 'yellow' },
        ["@function.method.call"] = { fg = 'yellow' },

        Keyword                   = { italic = true },

        --- Types
        ["@type"]                 = { fg = 'subtle' },
        ["@type.builtin"]         = { fg = 'pine', bold = true },
        -- ["@type.definition"] = {},
        -- ["@type.qualifier"] = {},

        --- Identifiers
        Identifier                = { fg = 'red' },
        -- ["@variable"]         = { fg = 'iris', italic = true },
        -- ["@variable.builtin"]   = { fg = palette.love, bold = styles.bold },
        ["@parameter"]            = { fg = 'red', italic = true },
        ["@variable.parameter"]   = { fg = 'red', italic = true },
        ["@variable.member"]      = { fg = 'gold' },

        ["@property"]             = { fg = 'gold', italic = true },
        -- ["@attribute"]        = { fg = "red" },

        -- Blend colours against the "base" background
        Cursor                    = { bg = 'base', blend = 10, underline = true },
        CursorLine                = { bg = 'foam', blend = 10 },
        StatusLine                = { fg = 'love', bg = 'love', blend = 10 },
    }
})

function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none", fg = "none" })
end

ColorMyPencils()
