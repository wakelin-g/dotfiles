return {
    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
    },
    {
        "lambdalisue/suda.vim",
        config = function()
            vim.g["suda#prompt"] = "Enter administrator password: "
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            auto_reload_on_write = true,
            disable_netrw = true,
            hijack_cursor = true,
            hijack_netrw = true,
            hijack_unnamed_buffer_when_opening = false,
            open_on_tab = false,
            respect_buf_cwd = true,
            sort_by = "name",
            sync_root_with_cwd = true,
            view = {
                adaptive_size = false,
                side = "left",
                centralize_selection = true,
                preserve_window_proportions = true,
                width = 30,
                number = true,
                relativenumber = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = false,
                highlight_opened_files = "none",
                indent_markers = {
                    enable = true,
                },
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = false,
                    },
                    glyphs = {
                        default = "󰈚",
                        symlink = "",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                            symlink_open = "",
                            arrow_open = "",
                            arrow_closed = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
                symlink_destination = true,
            },
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            filters = {
                dotfiles = false,
                custom = { ".DS_Store" },
                exclude = {},
            },
            actions = {
                use_system_clipboard = true,
                change_dir = {
                    enable = true,
                    global = false,
                },
                open_file = {
                    quit_on_open = false,
                    resize_window = false,
                    window_picker = {
                        enable = true,
                        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                        exclude = {
                            filetype = {
                                "notify",
                                "qf",
                                "diff",
                                "fugitive",
                                "fugitiveblame",
                            },
                            buftype = { "terminal", "help" },
                        },
                    },
                },
                remove_file = {
                    close_window = true,
                },
            },
            diagnostics = {
                enable = false,
                show_on_dirs = false,
                debounce_delay = 50,
            },
            filesystem_watchers = {
                enable = true,
            },
            git = {
                enable = false,
                ignore = true,
            },
            trash = {
                cmd = "gio trash",
                require_confirm = true,
            },
        },
    },
    -- {
    --     "NvChad/nvterm",
    --     config = function()
    --         require("nvterm").setup({
    --             terminals = {
    --                 shell = vim.o.shell,
    --                 list = {},
    --                 type_opts = {
    --                     float = {
    --                         relative = 'editor',
    --                         row = 0.125,
    --                         col = 0.125,
    --                         width = 0.75,
    --                         height = 0.75,
    --                         border = 'single',
    --                     },
    --                     horizontal = {
    --                         location = 'rightbelow',
    --                         split_ratio = .2,
    --                     },
    --                     vertical = {
    --                         location = 'rightbelow',
    --                         split_ratio = .3,
    --                     },
    --                 },
    --             },
    --             behaviour = {
    --                 autoclose_on_quit = {
    --                     enabled = false,
    --                     confirm = true,
    --                 },
    --                 close_on_exit = true,
    --                 auto_insert = true,
    --             },
    --         })
    --         local nvt = require("nvterm.terminal")
    --         local toggle_modes = { 'n', 't' }
    --         local mappings = {
    --             {toggle_modes, '<C-g>', function () nvt.toggle('float') end},
    --             {toggle_modes, '<C-\\>', function () nvt.toggle('horizontal') end},
    --         }
    --         local opts = { noremap = true, silent = true }
    --         for _, mapping in ipairs(mappings) do
    --             vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    --         end
    --     end,
    -- },
    {
        "windwp/nvim-autopairs",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            require("nvim-autopairs").setup({})
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
        event = "InsertEnter",
    },
    {
        "nvimdev/template.nvim",
        cmd = { "Template", "TemProject" },
        config = function()
            require("template").setup({
                temp_dir = "~/.config/nvim/template/",
                author = "Griffen Wakelin",
                email = "wakelin@dal.ca",
            })
        end,
    },
    {
        "wakelin-g/run.nvim",
        dev = false,
        name = "run.nvim",
        event = "VeryLazy",
        config = function()
            require("run").setup({
                commands = {
                    ["c"] = {
                        "clang " .. vim.fn.expand("%") .. " && ./a.out",
                        "gcc-13 " .. vim.fn.expand("%") .. " && ./a.out",
                    },
                    ["cpp"] = {
                        "clang++ " .. vim.fn.expand("%") .. " && ./a.out",
                    },
                    ["python"] = { "python3 " .. vim.fn.expand("%") },
                    ["rust"] = { "cargo run" },
                    ["go"] = { "go run " .. vim.fn.expand("%") },
                    ["lua"] = {
                        "lua " .. vim.fn.expand("%"),
                        "luafile " .. vim.fn.expand("%"),
                    },
                },
                win_width = 40,
                set_wrap = true,
                use_default_bindings = true,
            })
        end,
    },
    {
        dir = "~/.config/plugs/scratch-buffer/",
        enabled = false,
        name = "scratch-buffer",
        config = function()
            require("scratch-buffer").setup({})
        end,
    },
    {
        dir = "~/.config/plugs/eln.nvim/",
        enabled = true,
        name = "eln.nvim",
    },
}
