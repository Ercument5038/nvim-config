return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local hide_in_width = function()
            return vim.fn.winwidth(0) > 80
        end

        local diagnostics = {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn" },
            symbols = { error = " ", warn = " " },
            colored = false,
            update_in_insert = false,
            always_visible = true,
        }

        local diff = {
            "diff",
            colored = false,
            symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
            cond = hide_in_width,
        }

        local mode = {
            "mode",
            fmt = function(str)
                return "-- " .. str .. " --"
            end,
        }

        local filetype = {
            "filetype",
            icons_enabled = false,
            icon = nil,
        }

        local branch = {
            "branch",
            icons_enabled = true,
            icon = "",
        }

        local location = {
            "location",
            padding = 0,
        }

        -- Define the custom date function
        local function customDate()
            local date = os.date("%d-%m-%Y")
            return date
        end

        -- Define the custom time function
        local function customTime()
            local time = tostring(os.date("%H:%M"))
            if os.time() % 2 == 1 then
                time = time:gsub(":", " ")
            end -- make the `:` blink
            return time
        end

        local spaces = function()
            return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
        end

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "rose-pine",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch, diagnostics },
                lualine_c = { "filename", "progress" },
                -- lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_x = { diff, spaces, "encoding", filetype },
                lualine_y = { location },
                lualine_z = { customTime, customDate },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })       
    end
}
