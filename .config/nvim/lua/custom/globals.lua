P = function(v)
    print(vim.inspect(v))
    return v
end

IS_MACOS = vim.loop.os_uname().sysname == "Darwin"

-- if Linux, enable osc52 sequence for tmux
if vim.loop.os_uname().sysname == "Linux" then
    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        },
        paste = {
            ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
            ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        },
    }
end
