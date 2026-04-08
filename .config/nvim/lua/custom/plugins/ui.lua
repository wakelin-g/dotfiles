---@diagnostic disable: missing-fields
local plugins = {
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
    "mawkler/modicator.nvim",
    enabled = true,
    config = function()
      require("modicator").setup({
        show_warnings = false,
        highlights = {
          defaults = { bold = true },
        }
      })
    end,
  },
  {
    -- breaks swift lsp for some reason
    "brenoprata10/nvim-highlight-colors",
    enabled = false,
    opts = {},
  },
  {
    -- do I even still need this with render-markdown?
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = { signs = false },
  },
  {
    "rcarriga/nvim-notify",
    enabled = false,
    config = function()
      require("notify").setup({
        -- background_color = "NotifyBackground",
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
    enabled = false,
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
                { event = "lsp",      kind = "message" },
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
                { event = "lsp",      kind = "message" },
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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "rmd" },
        latex = {
          enabled = true,
          converter = "/Users/griffen/mambaforge/envs/nvim/bin/latex2text",
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>zm", "<cmd>ZenMode<cr>", desc = "zenmode toggle" },
    },
    opts = {},
  },
}

return plugins
