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
            local utils = require("neo-tree.utils")
            local cmds = require("neo-tree.command")
            local inputs = require("neo-tree.ui.inputs")

            local function trash(state)
                local tree = state.tree
                local node = tree:get_node()
                if node.type == "message" then
                    return
                end
                local _, name = utils.split_path(node.path)
                local msg = string.format("Are you sure you want to trash '%s'?", name)
                inputs.confirm(msg, function(confirmed)
                    if not confirmed then
                        return
                    end
                    vim.api.nvim_command("silent !trash -F " .. node.path)
                    require("neo-tree.sources.manager").refresh(state.name)
                end)
            end

            local function trash_visual(state, selected_nodes)
                local paths_to_trash = {}
                for _, node in ipairs(selected_nodes) do
                    if node.type ~= 'message' then
                        table.insert(paths_to_trash, node.path)
                    end
                end
                local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
                inputs.confirm(msg, function(confirmed)
                    if not confirmed then
                        return
                    end
                    for _, path in ipairs(paths_to_trash) do
                        vim.api.nvim_command("silent !trash -F " .. path)
                    end
                    require("neo-tree.sources.manager").refresh(state.name)
                end)
            end

            require("neo-tree").setup({
                close_if_last_window = true,
                enable_git_status = false,
                enable_diagnostics = true,
                sources = { "filesystem", "buffer", "git_status" },
                filesystem = {
                    commands = {
                        delete = trash,
                        delete_visual = trash_visual,
                    },
                },

            })
        end,
        keys = {
            { "<leader>e", "<cmd>Neotree toggle reveal<cr>", desc = "Explorer" },
        },
    },
    {
        "ThePrimeagen/harpoon",
        lazy = true,
        event = { "VeryLazy" },
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
