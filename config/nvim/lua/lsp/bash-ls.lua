-- sudo npm i -g bash-language-server
require'lspconfig'.bashls.setup {on_attach = require'vim.lsp'.common_on_attach}
