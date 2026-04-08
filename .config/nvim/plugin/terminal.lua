vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
  backdrop = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
    vim.bo[buf].buflisted = false
  else
    buf = vim.api.nvim_create_buf(false, true) -- false, true = no file, scratch buffer
    vim.bo[buf].buflisted = false
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "none",
    zindex = 50,
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function wo(win, k, v)
  if vim.api.nvim_set_option_value then
    vim.api.nvim_set_option_value(k, v, { scope = "local", win = win })
  else
    vim.wo[win][k] = v
  end
end

local function create_backdrop()
  local backdrop_buf = vim.api.nvim_create_buf(false, true)
  local backdrop_win = vim.api.nvim_open_win(backdrop_buf, false, {
    relative = "editor",
    width = vim.o.columns,
    height = vim.o.lines,
    row = 0,
    col = 0,
    style = "minimal",
    focusable = false,
    zindex = 49
  })
  vim.api.nvim_set_hl(0, "LazyBackdrop", { bg = "#000000", default = true })
  wo(backdrop_win, "winhighlight", "Normal:LazyBackdrop")
  wo(backdrop_win, "winblend", 60)
  vim.bo[backdrop_buf].buftype = "nofile"
  vim.bo[backdrop_buf].filetype = "terminal_backdrop"
  return { buf = backdrop_buf, win = backdrop_win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    if not vim.api.nvim_win_is_valid(state.backdrop.win) then
      state.backdrop = create_backdrop()
    end
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
    vim.api.nvim_win_hide(state.backdrop.win)
  end
end


vim.api.nvim_create_augroup("griffen-term", {})
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  group = "griffen-term",
  command = "startinsert",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = "griffen-term",
  callback = function(args)
    if vim.bo[args.buf].buftype == "terminal" then
      vim.cmd.startinsert()
    end
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = "griffen-term",
  pattern = "*",
  callback = function()
    vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
    vim.keymap.set(
      { "n", "i", "t" },
      "<C-t>",
      "<cmd>Floaterminal<cr>",
      { noremap = true, desc = "toggle terminal" }
    )
  end
})
