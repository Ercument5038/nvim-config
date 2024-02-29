return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            window = {
                width = 30,
                mappings = {
                    ['h'] = function(state)
                        local node = state.tree:get_node()
                        if node.type == 'directory' and node:is_expanded() then
                            require('neo-tree.sources.filesystem').toggle_directory(state, node)
                        else
                            require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
                        end
                    end,
                    ['l'] = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        if node.type == 'directory' then
                            if not node:is_expanded() then
                                require('neo-tree.sources.filesystem').toggle_directory(state, node)
                            elseif node:has_children() then
                                require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
                            end
                        end
                        if node.type == 'file' then
                            require('neo-tree.utils').open_file(state, path)
                        end
                    end,                
                },
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        -- auto close
                        -- vimc.cmd("Neotree close")
                        -- OR
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        vim.cmd("highlight! Cursor blend=100")
                    end,
                },
                {
                    event = "neo_tree_buffer_leave",
                    handler = function()
                        vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
                    end,
                },
            }
        })
        vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})
    end,
}
