-- sudo npm i -g bash-language-server
require 'lspconfig'.bashls.setup {

    on_attach = require 'vim.lsp'.common_on_attach,

    capabilities = require 'cmp_nvim_lsp'.update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
}
