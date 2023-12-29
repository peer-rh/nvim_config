return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                enable_git_status = false,
                enable_diagnostics = true,
            })
        end,
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" }
        },
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            local ui = require("harpoon.ui")
            require("which-key").register({
                ["<leader>h"] = {
                    "+harpoon",
                    a = { require("harpoon.mark").add_file, "Add File" },
                    e = { ui.toggle_quick_menu, "Menu" },
                    h = { function() ui.nav_file(1) end, "First Buffer" },
                    j = { function() ui.nav_file(2) end, "Second Buffer" },
                    k = { function() ui.nav_file(3) end, "Third Buffer" },
                    l = { function() ui.nav_file(4) end, "Fourth Buffer" },
                }
            })
        end,
    },
}
