
local root_files = { "sketch.yaml" }
local paths = vim.fs.find(root_files, { stop = vim.env.HOME })
local root_dir = vim.fs.dirname(paths[1])

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.semanticTokens = vim.NIL
default_capabilities.workspace.semanticTokens = vim.NIL

if root_dir then
    vim.lsp.start({
        cmd = {
            "arduino-language-server",
            "-cli-config",
            "/Users/griffen/Library/Arduino15/arduino-cli.yaml",
            "-fqbn",
            "arduino:avr:nano",
            "-log",
        },
        root_dir = root_dir,
    })
end
