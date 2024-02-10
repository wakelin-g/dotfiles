local M = {
    "nvim-telescope/telescope.nvim",
    event = { "Bufenter" },
    cmd = { "Telescope" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-bibtex.nvim",
    },
}

function M.init()
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("live_grep_args")
    -- require("telescope").load_extension("notify")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("media_files")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("bibtex")
    -- require("telescope").load_extension("zk")
    map("n", "<leader>u", "<cmd>Telescope undo<CR>", { silent = true, desc = "telescope: open undo float"})
    map("n", "<leader>cc", "<cmd>Telescope bibtex<CR>", { silent = true, desc = "telescope: insert bibtex ref"})
    map("n", "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", { silent = true, desc = "telescope: find"})
    map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { silent = true, desc = "telescope: live grep"})
    map("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { silent = true, desc = "telescope: grep string under cursor"})
    map("n", "<leader>fa", "<cmd>Telescope live_grep_args<CR>", { silent = true, desc = "telescope: live grep args"})
    map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { silent = true, desc = "telescope: search open buffers"})
    map("n", "<leader>fh", "<cmd>Telescope oldfiles<CR>", { silent = true, desc = "telescope: search files by history"})
    map("n", "<leader>fm", "<cmd>Telescope media_files<CR>", { silent = true, desc = "telescope: media files"})
    map("n", "<leader>fz", "<cmd>Telescope zk notes<CR>", { silent = true, desc = "telescope: search notes"})
    map("n", "<leader>qw", "<cmd>Telescope file_browser<CR>", { silent = true, desc = "telescope: open file browser"})
end

M.opts = {
    defaults = {
        initial_mode = "insert",
        selection_caret = ">> ",
        scroll_strategy = "limit",
        results_title = false,
        layout_strategy = "horizontal",
        path_display = { "absolute" },
        file_ignore_patterns = { ".git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
        vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--trim" },
        layout_config = {
            horizontal = {
                preview_width = 0.5,
                height = 100,
                width = 100,
                preview_cutoff = 100,
                prompt_position = "top",
            },
        },
    },
    pickers = {
        keymaps = {
            theme = "dropdown",
        },
        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        live_grep_args = {
            auto_quoting = true,
        },
        undo = {
            side_by_side = true,
        },
        bibtex = {},
        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
        },
        media_files = {
            filetypes = {
                "png",
                "jpg",
                "jpeg",
                "svg",
                "pdf"
            },
            find_cmd = "rg",
        },
    },
}

return M
