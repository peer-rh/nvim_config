return {
    {
        'rose-pine/neovim',
        lazy = false,
        priority = 1000,
        name = 'rose-pine',
        config = function()
            vim.cmd([[set termguicolors]])
            vim.cmd([[colorscheme rose-pine]])
        end,
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        "folke/which-key.nvim",
        config = true
    },
}