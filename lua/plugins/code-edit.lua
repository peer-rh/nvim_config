return {
    {
        'kevinhwang91/nvim-ufo',
        lazy = true,
        event = { 'BufRead', 'VeryLazy' },
        dependencies = {
            { 'kevinhwang91/promise-async' },
        },
        config = function()

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
            local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require('lspconfig')[ls].setup({
                    capabilities = capabilities
                    -- you can add other fields for setting up lsp server in this table
                })
            end
            require('ufo').setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        config = true,
    },
    {
        "terryma/vim-expand-region"
    },
    {
        'numToStr/Comment.nvim',
        config = true,
    },

}
