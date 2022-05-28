-- sudo npm install -g yaml-language-server
require 'lspconfig'.yamlls.setup{
    capabilities = require 'cmp_nvim_lsp'.update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )
}
