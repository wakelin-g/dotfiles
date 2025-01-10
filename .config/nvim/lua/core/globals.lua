P = function(v)
    print(vim.inspect(v))
    return v
end

IS_MACOS = vim.loop.os_uname().sysname == "Darwin"
