return {
    {
        "utilyre/barbecue.nvim", -- adds vscode-like winbar (shows code context in top left of buffer)
        name = "barbecue",
        version = "*",
        theme = "auto",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            show_dirname = false,
            show_basename = false,
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "BufEnter",
        dependencies = {
            { "nvim-tree/nvim-web-devicons", opt = true },
            { "lewis6991/gitsigns.nvim" },
        },
        config = function()
            local function molten()
                local kernels = require("molten.status").kernels()
                if kernels == "" then
                    return ""
                end
                return "[Molten]: " .. kernels
            end
            local function get_lsp()
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_clients()
                local msg = "[" .. "No active lsp" .. "]"
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return "[LSP]: " .. client.name
                    end
                end
                return msg
            end
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "|" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = { molten, get_lsp },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dev = false,
        name = "bufferline.nvim",
        event = "BufEnter",
        keys = {
            { "<S-h>", "<cmd>bprev<cr>", desc = "Prev buffer" },
            { "<S-l>", "<cmd>bnext<cr>", desc = "Next buffer" },
        },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    tab_size = 22,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    show_tab_indicators = true,
                    color_icons = true,
                    separator_style = "thin",
                    always_show_bufferline = true,
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        opts = {
            window = {
                backdrop = 0.75,
                width = 80,
                height = 1,
                options = {
                    signcolumn = "no",
                    number = false,
                    relativenumber = false,
                    cursorline = false,
                    cursorcolumn = false,
                    foldcolumn = "0",
                    list = false,
                },
            },
            plugins = {
                tmux = { enabled = true },
            },
        },
    },
    {
        "xiyaowong/transparent.nvim",
        enabled = true,
        config = function()
            vim.g.transparent_groups = vim.list_extend(
                vim.g.transparent_groups or {},
                vim.tbl_map(function(v)
                    return v.hl_group
                end, vim.tbl_values(
                    require("bufferline.config").highlights
                ))
            )
            vim.cmd("TransparentEnable")
        end,
    },
    {
        "mawkler/modicator.nvim",
        enabled = true,
        config = function()
            require("modicator").setup({
                show_warnings = false,
                highlights = {
                    defaults = {
                        bold = true,
                        italic = true,
                    },
                },
                integration = {
                    lualine = {
                        enabled = true,
                    },
                },
            })
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = { signs = false },
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_color = "NotifyBackground",
                level = 2,
                minimum_width = 50,
                render = "default",
                stages = "static",
                timeout = 5000,
                top_down = true,
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                cmdline = {
                    enabled = true,
                    format = {
                        lua = false,
                    },
                },
                messages = {
                    enabled = true,
                },
                popupmenu = {
                    enabled = true,
                },
                commands = {
                    history = {
                        view = "split",
                        opts = { enter = true, format = "details" },
                        filter = {
                            any = {
                                { event = "notify" },
                                { error = true },
                                { warning = true },
                                { event = "msg_show", kind = { "" } },
                                { event = "lsp", kind = "message" },
                            },
                        },
                    },
                    last = {
                        view = "popup",
                        opts = { enter = true, format = "details" },
                        filter = {
                            any = {
                                { event = "notify" },
                                { error = true },
                                { warning = true },
                                { event = "msg_show", kind = { "" } },
                                { event = "lsp", kind = "message" },
                            },
                        },
                        filter_opts = { count = 1 },
                    },
                },
                notify = {
                    enabled = true,
                },
                lsp = {
                    progress = { enabled = false },
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    hover = {
                        enabled = true,
                    },
                    signature = {
                        enabled = true,
                    },
                    message = {
                        enabled = true,
                    },
                },
                health = { checker = true },
                presets = {
                    command_palette = true,
                    lsp_doc_border = true,
                },
            })
        end,
    },
    {
        "Tyler-Barham/floating-help.nvim",
        enabled = true,
        config = function()
            require("floating-help").setup({
                width = 0.9,
                height = 0.9,
                position = "C",
            })
        end,
    },
    {
        "MeanderingProgrammer/markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup({})
        end,
    },
}
