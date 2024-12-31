local plugin = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-bibtex.nvim",
    },
    event = "VimEnter",
}

function plugin.init()
    local u = {}

    function u.set_keymap(mode, lhs, rhs, desc_or_opts, opts)
        if not opts then
            opts = type(desc_or_opts) == "table" and desc_or_opts
                or { desc = desc_or_opts }
        else
            opts.desc = desc_or_opts
        end
        vim.keymap.set(
            mode,
            lhs,
            rhs,
            vim.tbl_extend("keep", opts, { silent = true })
        )
    end

    function u.set_keymaps(default_mode, maps, fallback_opts)
        fallback_opts = fallback_opts or {}
        for _, map in ipairs(maps) do
            local mode, lhs, rhs, desc, opts =
                map.mode or default_mode, map[1], map[2], map[3], map[4]
            if not opts then
                opts = type(desc) == "table" and desc or { desc = desc }
            else
                opts.desc = desc
            end
            map.mode, map[1], map[2], map[3], map[4] = nil, nil, nil, nil, nil
            local ops = vim.tbl_extend(
                "keep",
                map,
                opts,
                fallback_opts,
                { silent = true }
            )
            u.set_keymap(mode, lhs, rhs, ops)
        end
    end
    u.set_keymaps("n", {
        {
            "<leader><leader>",
            function()
                require("telescope.builtin").buffers()
            end,
            "[telescope] buffers",
        },
        {
            "<leader>sn",
            function()
                require("telescope.builtin").find_files({
                    cwd = vim.fn.stdpath("config"),
                })
            end,
            "[telescope] search nvim config",
        },
        {
            "<leader>ft",
            "<cmd>Telescope find_template name-templatename<cr>",
            "[telescope] search tempates",
        },
        {
            "<leader>fd",
            function()
                require("telescope.builtin").diagnostics()
            end,
            "[telescope] diagnostics",
        },
        {
            "<leader>fo",
            "<cmd>ObsidianSearch<CR>",
            "[telescope] obsidian search",
        },
        {
            "<Leader>fk",
            function()
                require("telescope.builtin").keymaps()
            end,
            "[telescope] keymaps",
        },
        {
            "<Leader>ff",
            function()
                require("telescope.builtin").find_files()
            end,
            "[telescope] files",
        },
        {
            "<Leader>fg",
            function()
                require("telescope.builtin").live_grep()
            end,
            "[telescope] live grep",
        },
        {
            "<Leader>fn",
            "<cmd>Telescope notify<cr>",
            "[telescope] search notify",
        },
        {
            "<C-e>",
            "<cmd>Telescope bibtex format=markdown<cr>",
            "[telescope] search bibtex",
        },
        {
            "<Leader>fh",
            function()
                require("telescope.builtin").help_tags()
            end,
            "[telescope] help tags",
        },
        {
            "<Leader>fu",
            "<cmd>Telescope undo<cr>",
            "[telescope] search undo",
        },
        {
            "<Leader>fr",
            function()
                require("telescope.builtin").lsp_references({
                    layout_strategy = "vertical",
                })
            end,
            "[telescope] lsp references",
        },
        {
            "<Leader>fs",
            function()
                require("telescope.builtin").builtin()
            end,
            "[telescope] search telescope",
        },
        {
            "<Leader>f/",
            function()
                require("telescope.builtin").live_grep({
                    path_display = { tail = true },
                    prompt_title = "Search Buffer Content",
                    search_dirs = { vim.fn.expand("%:p") },
                })
            end,
            "[telescope] buffer content",
        },
    })
end

function plugin.config()
    local Layout = require("nui.layout")
    local Popup = require("nui.popup")

    local telescope = require("telescope")
    local TSLayout = require("telescope.pickers.layout")

    local function make_popup(options)
        local popup = Popup(options)
        function popup.border:change_title(title)
            popup.border.set_text(popup.border, "top", title)
        end
        return TSLayout.Window(popup)
    end

    telescope.setup({
        defaults = {
            dynamic_preview_title = true,
            layout_strategy = "flex",
            layout_config = {
                horizontal = {
                    size = {
                        width = "90%",
                        height = "60%",
                    },
                },
                vertical = {
                    size = {
                        width = "90%",
                        height = "90%",
                    },
                },
            },
            create_layout = function(picker)
                local border = {
                    results = {
                        top_left = "┌",
                        top = "─",
                        top_right = "┬",
                        right = "│",
                        bottom_right = "",
                        bottom = "",
                        bottom_left = "",
                        left = "│",
                    },
                    results_patch = {
                        minimal = {
                            top_left = "┌",
                            top_right = "┐",
                        },
                        horizontal = {
                            top_left = "┌",
                            top_right = "┬",
                        },
                        vertical = {
                            top_left = "├",
                            top_right = "┤",
                        },
                    },
                    prompt = {
                        top_left = "├",
                        top = "─",
                        top_right = "┤",
                        right = "│",
                        bottom_right = "┘",
                        bottom = "─",
                        bottom_left = "└",
                        left = "│",
                    },
                    prompt_patch = {
                        minimal = {
                            bottom_right = "┘",
                        },
                        horizontal = {
                            bottom_right = "┴",
                        },
                        vertical = {
                            bottom_right = "┘",
                        },
                    },
                    preview = {
                        top_left = "┌",
                        top = "─",
                        top_right = "┐",
                        right = "│",
                        bottom_right = "┘",
                        bottom = "─",
                        bottom_left = "└",
                        left = "│",
                    },
                    preview_patch = {
                        minimal = {},
                        horizontal = {
                            bottom = "─",
                            bottom_left = "",
                            bottom_right = "┘",
                            left = "",
                            top_left = "",
                        },
                        vertical = {
                            bottom = "",
                            bottom_left = "",
                            bottom_right = "",
                            left = "│",
                            top_left = "┌",
                        },
                    },
                }

                local results = make_popup({
                    focusable = false,
                    border = {
                        style = border.results,
                        text = {
                            top = picker.results_title,
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat",
                    },
                })

                local prompt = make_popup({
                    enter = true,
                    border = {
                        style = border.prompt,
                        text = {
                            top = picker.prompt_title,
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat",
                    },
                })

                local preview = make_popup({
                    focusable = false,
                    border = {
                        style = border.preview,
                        text = {
                            top = picker.preview_title,
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat",
                    },
                })

                local box_by_kind = {
                    vertical = Layout.Box({
                        Layout.Box(preview, { grow = 1 }),
                        Layout.Box(results, { grow = 1 }),
                        Layout.Box(prompt, { size = 3 }),
                    }, { dir = "col" }),
                    horizontal = Layout.Box({
                        Layout.Box({
                            Layout.Box(results, { grow = 1 }),
                            Layout.Box(prompt, { size = 3 }),
                        }, { dir = "col", size = "50%" }),
                        Layout.Box(preview, { size = "50%" }),
                    }, { dir = "row" }),
                    minimal = Layout.Box({
                        Layout.Box(results, { grow = 1 }),
                        Layout.Box(prompt, { size = 3 }),
                    }, { dir = "col" }),
                }

                local function get_box()
                    local strategy = picker.layout_strategy
                    if strategy == "vertical" or strategy == "horizontal" then
                        return box_by_kind[strategy], strategy
                    end

                    local height, width = vim.o.lines, vim.o.columns
                    local box_kind = "horizontal"
                    if width < 100 then
                        box_kind = "vertical"
                        if height < 40 then
                            box_kind = "minimal"
                        end
                    end
                    return box_by_kind[box_kind], box_kind
                end

                local function prepare_layout_parts(layout, box_type)
                    layout.results = results
                    results.border:set_style(border.results_patch[box_type])

                    layout.prompt = prompt
                    prompt.border:set_style(border.prompt_patch[box_type])

                    if box_type == "minimal" then
                        layout.preview = nil
                    else
                        layout.preview = preview
                        preview.border:set_style(border.preview_patch[box_type])
                    end
                end

                local function get_layout_size(box_kind)
                    return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
                end

                local box, box_kind = get_box()
                local layout = Layout({
                    relative = "editor",
                    position = "50%",
                    size = get_layout_size(box_kind),
                }, box)

                layout.picker = picker
                prepare_layout_parts(layout, box_kind)

                local layout_update = layout.update
                function layout:update()
                    local box, box_kind = get_box()
                    prepare_layout_parts(layout, box_kind)
                    layout_update(
                        self,
                        { size = get_layout_size(box_kind) },
                        box
                    )
                end

                return TSLayout(layout)
            end,
            mappings = {
                i = {
                    ["<C-s>"] = "select_horizontal",
                },
                n = {
                    ["<C-s>"] = "select_horizontal",
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
        pickers = {
            find_files = {
                find_command = { "fd", "--type", "f", "--color", "never" },
                hidden = true,
            },
            live_grep = {
                additional_args = function()
                    return { "--hidden" }
                end,
                glob_pattern = { "!.git" },
            },
        },
    })

    local exts = {
        "fzf",
        "live_grep_args",
        "undo",
        "bibtex",
        "find_template",
        "run",
        "notify",
    }
    for _, ext in pairs(exts) do
        pcall(require("telescope").load_extension, ext)
    end
end

return plugin
