-- sudo pacman -S clang
require'lspconfig'.clangd.setup{
    capabilities = require 'cmp_nvim_lsp'.update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
}

--   Commands:
--   - ClangdSwitchSourceHeader: Switch between source/header
--
--   Default Values:
--     capabilities = default capabilities, with offsetEncoding utf-8
--     cmd = { "clangd", "--background-index" }
--     filetypes = { "c", "cpp", "objc", "objcpp" }
--     on_init = function to handle changing offsetEncoding
--     root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git") or dirname
