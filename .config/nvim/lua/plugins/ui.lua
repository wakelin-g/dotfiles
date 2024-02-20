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
    -- {
    --     "nvim-lualine/lualine.nvim",
    --     event = "BufEnter",
    --     dependencies = {
    --         {"nvim-tree/nvim-web-devicons", opt = true},
    --         {"lewis6991/gitsigns.nvim"},
    --     },
    --     config = function()
    --         require("lualine").setup({})
    --     end,
    -- },
    {
        "hedyhli/outline.nvim",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
            require("outline").setup({})
        end,
    },
    {
        "akinsho/bufferline.nvim",
        event = "BufEnter",
        branch = "main",
        keys = {
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
        },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    tab_size = 22,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    color_icons = true,
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    show_tab_indicators = true,
                    separator_style = "thin",
                    always_show_bufferline = true,
                },
                highlights = require("rose-pine.plugins.bufferline")
            })
        end
    },
    {
        "maxmx03/roseline",
        event = "BufEnter",
        dependencies = {
            {"rose-pine/neovim"},
            {"lewis6991/gitsigns.nvim"},
        },
        config = function()
            require("roseline").setup({
                theme = "rose-pine",
                icons = {
                    vim = '',
                    git = {
                        head = '',
                        added = '',
                        changed = '',
                        removed = '',
                    },
                    diagnostic = {
                        Error = '',
                        Warning = '',
                        Information = '',
                        Question = '',
                        Hint = '󰌶',
                        Debug = '',
                        Ok = '󰧱',
                    },
                    os = {
                        Linux = '',
                        microsoft = '',
                        Darwin = '',
                    },
                    default = { left = '', right = '' },
                    block = { left = '█', right = '█' },
                    round = { left = '', right = '' },
                },
            })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({})
        end
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
      }
    },
  }
}
