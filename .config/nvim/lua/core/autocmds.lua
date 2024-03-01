-- only highlight when searching
vim.api.nvim_create_autocmd("CmdlineEnter", {
	callback = function()
		local cmd = vim.v.event.cmdtype
		if cmd == "/" or cmd == "?" then
			vim.opt.hlsearch = true
		end
	end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		local cmd = vim.v.event.cmdtype
		if cmd == "/" or cmd == "?" then
			vim.opt.hlsearch = false
		end
	end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = { c = false, r = false, o = false }
	end,
})

-- remap j/k to gj/gk in markdown files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		local map = vim.keymap.set
		vim.opt.wrap = true
		map({ "n" }, "j", "gj", { noremap = true })
		map({ "n" }, "k", "gk", { noremap = true })
		map({ "n" }, "gk", "k", { noremap = true })
		map({ "n" }, "gj", "j", { noremap = true })
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MoltenInitPost",
	callback = function()
		vim.keymap.set(
			"n",
			"<localleader>e",
			":MoltenEvaluateOperator<CR>",
			{ desc = "run operator selection", buffer = true, silent = false }
		)
		vim.keymap.set(
			"n",
			"<localleader>rl",
			":MoltenEvaluateLine<CR>",
			{ desc = "execute line", buffer = true, silent = false }
		)
		vim.keymap.set(
			"n",
			"<localleader>rr",
			":MoltenReevaluateCell<CR>",
			{ desc = "re-evaluate cell", buffer = true, silent = false }
		)
		vim.keymap.set(
			"v",
			"<localleader>r",
			":<C-u>MoltenEvaluateVisual<CR>gv",
			{ desc = "execute visual selection", buffer = true, silent = false }
		)
		vim.keymap.set(
			"n",
			"<localleader>rd",
			":MoltenDelete<CR>",
			{ desc = "molten delete cell", buffer = true, silent = false }
		)
		vim.keymap.set(
			"n",
			"<localleader>oh",
			":MoltenHideOutput<CR>",
			{ desc = "hide output", buffer = true, silent = false }
		)
		vim.keymap.set(
			"n",
			"<localleader>os",
			":noautocmd MoltenEnterOutput<CR>",
			{ desc = "show/enter output", buffer = true, silent = false }
		)
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("griffen_close_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"Jaq",
		"lir",
		"DressingSelect",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- jump to last known position
vim.api.nvim_create_autocmd("BufRead", {
	callback = function(opts)
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			buffer = opts.buf,
			callback = function()
				local ft = vim.bo[opts.buf].filetype
				local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
				if
					not (ft:match("commit") and ft:match("rebase"))
					and last_known_line > 1
					and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
				then
					vim.api.nvim_feedkeys([[g`"]], "nx", false)
				end
			end,
		})
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("griffen_last_loc", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- strip trailing spaces before write
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("griffen_strip_spaces", { clear = true }),
	pattern = { "*" },
	callback = function()
		vim.cmd([[ %s/\s\+$//e ]])
	end,
})
