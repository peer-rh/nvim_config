return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            local lsp_zero = require('lsp-zero')

            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0

            lsp_zero.set_sign_icons({
                error = '',
                warn = '',
                hint = '',
                info = ''
            })
            require("which-key").register({
                c = {
                    "+code",
                    d = { vim.diagnostic.open_float, "Diagnostic Float" },
                    x = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
                    c = { vim.diagnostic.goto_next, "Next Diagnostic" },
                    a = { vim.lsp.buf.code_action, "Code Action" },
                    R = { vim.lsp.buf.references, "References" },
                    r = { vim.lsp.buf.rename, "Rename" },
                }
            }, { prefix = "<leader>" })
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
            vim.diagnostic.config({
                virtual_text = true
            })
        end,
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' }
        },
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = { 'VeryLazy', 'InsertEnter' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },         -- Required
            { 'hrsh7th/cmp-buffer' },           -- Optional
            { 'hrsh7th/cmp-path' },             -- Optional
            { 'saadparwaiz1/cmp_luasnip' },     -- Optional
            { 'hrsh7th/cmp-nvim-lua' },         -- Optional
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
            { 'onsails/lspkind.nvim' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lspkind = require('lspkind')
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        with_text = false,
                        maxwidth = 50,
                    })
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-l>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },
    {
        'github/copilot.vim',
        lazy = true,
        event = { 'InsertEnter', 'VeryLazy' },
        config = function()
            vim.cmd([[Copilot enable]])
        end
    },
    {
        'akinsho/flutter-tools.nvim',
        lazy = true,
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.diagnostics.eslint_d,
                },
            })
            vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        lazy = true,
        event = 'InsertEnter',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                autotag = {
                    enable = true,
                }
            }
        end
    },
    {
        'simrat39/symbols-outline.nvim',
        event = { 'VeryLazy' },
        config = true,
        keys = { { '<leader>ce', "<cmd>SymbolsOutline<cr>", desc = "Symbols" } },
    },
}
