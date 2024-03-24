return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-bibtex.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = {},
    config = function()
        require("telescope").setup({
            extensions = {
                -- ["ui-select"] = {
                -- 	require("telescope.themes").get_dropdown({}),
                -- },
                bibtex = {
                    depth = 2,
                },
            },
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                entry_prefix = "  ",
                initial_mode = "insert",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.5,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.9,
                    height = 0.9,
                    preview_cutoff = 120,
                },
                sorting_strategy = "ascending",
                selection_strategy = "reset",
                winblend = 0,
                path_display = { "truncate" },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                border = {},
                borderchars = {
                    "─",
                    "│",
                    "─",
                    "│",
                    "╭",
                    "╮",
                    "╯",
                    "╰",
                },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            },
        })

        local map = vim.keymap.set
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

        local builtin = require("telescope.builtin")
        map("n", "<leader>fh", builtin.help_tags, { desc = "search help" })
        map("n", "<leader>fk", builtin.keymaps, { desc = "search keymaps" })
        -- map("n", "<leader>ff", function()
        -- 	builtin.find_files(require("telescope.themes").get_dropdown({
        -- 		previewer = false,
        -- 	}))
        -- end, { desc = "search files" })
        map("n", "<leader>ff", builtin.find_files, { desc = "search files" })
        map(
            "n",
            "<leader>fw",
            builtin.grep_string,
            { desc = "search current word" }
        )
        map(
            "n",
            "<leader><leader>",
            builtin.buffers,
            { desc = "search existing buffers" }
        )
        map(
            "n",
            "<leader>fd",
            builtin.diagnostics,
            { desc = "search diagnostics" }
        )
        map(
            "n",
            "<leader>fo",
            "<cmd>ObsidianSearch<CR>",
            { silent = true, desc = "search obsidian" }
        )
        map(
            "n",
            "<leader>ft",
            ":Telescope find_template name-templatename<cr>",
            { desc = "search template" }
        )
        map("n", "<leader>fs", builtin.builtin, { desc = "search telescope" })
        map("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
        map(
            "n",
            "<leader>fn",
            "<cmd>Telescope notify<CR>",
            { desc = "search notify" }
        )
        map(
            "n",
            "<leader>fu",
            "<cmd>Telescope undo<CR>",
            { silent = true, desc = "search undo" }
        )
        map(
            { "n", "i" },
            "<C-e>",
            "<cmd>Telescope bibtex format=markdown<CR>",
            { silent = true, desc = "search bibtex ref" }
        )
        map("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(
                require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                })
            )
        end, { desc = "fuzzily search in current buffer" })
        map("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "live grep in open files",
            })
        end, { desc = "search in open files" })
        map("n", "<leader>sn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "search nvim config files" })
    end,
}
