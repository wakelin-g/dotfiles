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
                show_warnings = true,
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
        "MeanderingProgrammer/markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup({})
        end,
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({})
        end,
    },
    {
        "MunifTanjim/nui.nvim",
        event = "VeryLazy",
        -- config = function()
        --     local Input = require("nui.input")
        --     local Menu = require("nui.menu")
        --     local event = require("nui.utils.autocmd").event
        --
        --     local function get_prompt_text(prompt, default_prompt)
        --         local prompt_text = prompt or default_prompt
        --         if prompt_text:sub(-1) == ":" then
        --             prompt_text = "[" .. prompt_text:sub(1, -2) .. "]"
        --         end
        --         return prompt_text
        --     end
        --
        --     local function override_input()
        --         local UIInput = Input:extend("UIInput")
        --
        --         function UIInput:init(opts, on_done)
        --             local border_top_text =
        --                 get_prompt_text(opts.prompt, "[Input]")
        --             local default_value = tostring(opts.default or "")
        --
        --             UIInput.super.init(self, {
        --                 relative = "cursor",
        --                 position = {
        --                     row = 1,
        --                     col = 0,
        --                 },
        --                 size = {
        --                     -- minimum width 20
        --                     width = math.max(
        --                         20,
        --                         vim.api.nvim_strwidth(default_value)
        --                     ),
        --                 },
        --                 border = {
        --                     style = "rounded",
        --                     text = {
        --                         top = border_top_text,
        --                         top_align = "left",
        --                     },
        --                 },
        --                 win_options = {
        --                     winhighlight = "NormalFloat:Normal",
        --                 },
        --             }, {
        --                 default_value = default_value,
        --                 on_close = function()
        --                     on_done(nil)
        --                 end,
        --                 on_submit = function(value)
        --                     on_done(value)
        --                 end,
        --             })
        --
        --             -- cancel operation if cursor leaves input
        --             self:on(event.BufLeave, function()
        --                 on_done(nil)
        --             end, { once = true })
        --
        --             -- cancel operation if <Esc> is pressed
        --             self:map("n", "<Esc>", function()
        --                 on_done(nil)
        --             end, { noremap = true, nowait = true })
        --         end
        --
        --         local input_ui
        --
        --         vim.ui.input = function(opts, on_confirm)
        --             assert(
        --                 type(on_confirm) == "function",
        --                 "missing on_confirm function"
        --             )
        --
        --             if input_ui then
        --                 -- ensure single ui.input operation
        --                 vim.api.nvim_err_writeln(
        --                     "busy: another input is pending!"
        --                 )
        --                 return
        --             end
        --
        --             input_ui = UIInput(opts, function(value)
        --                 if input_ui then
        --                     -- if it's still mounted, unmount it
        --                     input_ui:unmount()
        --                 end
        --                 -- pass the input value
        --                 on_confirm(value)
        --                 -- indicate the operation is done
        --                 input_ui = nil
        --             end)
        --
        --             input_ui:mount()
        --         end
        --     end
        --
        --     local function override_select()
        --         local UISelect = Menu:extend("UISelect")
        --
        --         function UISelect:init(items, opts, on_done)
        --             local border_top_text =
        --                 get_prompt_text(opts.prompt, "[Select Item]")
        --             local kind = opts.kind or "unknown"
        --             local format_item = opts.format_item
        --                 or function(item)
        --                     return tostring(item.__raw_item or item)
        --                 end
        --
        --             local popup_options = {
        --                 relative = "editor",
        --                 position = "50%",
        --                 border = {
        --                     style = "rounded",
        --                     text = {
        --                         top = border_top_text,
        --                         top_align = "left",
        --                     },
        --                 },
        --                 win_options = {
        --                     winhighlight = "NormalFloat:Normal",
        --                 },
        --                 zindex = 999,
        --             }
        --
        --             if kind == "codeaction" then
        --                 -- change position for codeaction selection
        --                 popup_options.relative = "cursor"
        --                 popup_options.position = {
        --                     row = 1,
        --                     col = 0,
        --                 }
        --             end
        --
        --             local max_width = popup_options.relative == "editor"
        --                     and vim.o.columns - 4
        --                 or vim.api.nvim_win_get_width(0) - 4
        --             local max_height = popup_options.relative == "editor"
        --                     and math.floor(vim.o.lines * 80 / 100)
        --                 or vim.api.nvim_win_get_height(0)
        --
        --             local menu_items = {}
        --             for index, item in ipairs(items) do
        --                 if type(item) ~= "table" then
        --                     item = { __raw_item = item }
        --                 end
        --                 item.index = index
        --                 local item_text =
        --                     string.sub(format_item(item), 0, max_width)
        --                 menu_items[index] = Menu.item(item_text, item)
        --             end
        --
        --             local menu_options = {
        --                 min_width = vim.api.nvim_strwidth(border_top_text),
        --                 max_width = max_width,
        --                 max_height = max_height,
        --                 lines = menu_items,
        --                 on_close = function()
        --                     on_done(nil, nil)
        --                 end,
        --                 on_submit = function(item)
        --                     on_done(item.__raw_item or item, item.index)
        --                 end,
        --             }
        --
        --             UISelect.super.init(self, popup_options, menu_options)
        --
        --             -- cancel operation if cursor leaves select
        --             self:on(event.BufLeave, function()
        --                 on_done(nil, nil)
        --             end, { once = true })
        --         end
        --
        --         local select_ui = nil
        --
        --         vim.ui.select = function(items, opts, on_choice)
        --             assert(
        --                 type(on_choice) == "function",
        --                 "missing on_choice function"
        --             )
        --
        --             if select_ui then
        --                 -- ensure single ui.select operation
        --                 vim.api.nvim_err_writeln(
        --                     "busy: another select is pending!"
        --                 )
        --                 return
        --             end
        --
        --             select_ui = UISelect(items, opts, function(item, index)
        --                 if select_ui then
        --                     -- if it's still mounted, unmount it
        --                     select_ui:unmount()
        --                 end
        --                 -- pass the select value
        --                 on_choice(item, index)
        --                 -- indicate the operation is done
        --                 select_ui = nil
        --             end)
        --
        --             select_ui:mount()
        --         end
        --     end
        --
        --     override_input()
        --     override_select()
        -- end,
    },
}

return plugins
