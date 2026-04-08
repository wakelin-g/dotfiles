local plugins = {
  dir = "~/.config/plugs/scratch.nvim",
  name = "scratch",
  enabled = false,
  config = function()
    require("scratch").setup({
      scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch",
      window_cmd = "edit",
      use_telescope = true,
      file_picker = "fzflua",
      filetypes = { "md" },
    })
  end,
  event = "VeryLazy",
  dependencies = {
    { "ibhagwan/fzf-lua",             event = "VeryLazy" },
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" },
  },
}

return plugins
