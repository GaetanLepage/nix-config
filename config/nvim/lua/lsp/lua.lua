-- sudo pacman -S lua-language-server
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER ..
                            "/.config/nvim/ls/lua-language-server"
    sumneko_binary = "/Users/" .. USER ..
                         "/.config/nvim/ls/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    -- sumneko_root_path = "/home/" .. USER ..
    --                         "/.config/nvim/ls/lua-language-server"
    -- sumneko_binary = "/home/" .. USER ..
    --                      "/.config/nvim/ls/lua-language-server/bin/Linux/lua-language-server"

    -- Installed it with pacman
    sumneko_root_path = "/usr/share/lua-language-server"
    sumneko_binary = "/usr/sbin/lua-language-server"
else
    print("Unsupported system for sumneko")
end

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = require'vim.lsp'.common_on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}
