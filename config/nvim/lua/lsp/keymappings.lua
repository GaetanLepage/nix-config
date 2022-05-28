-- General LSP key mappings
local nmap = require 'utils'.nmap

nmap('gd', vim.lsp.buf.definition)
nmap('gD', vim.lsp.buf.references)
nmap('gt', vim.lsp.buf.type_definition)
nmap('gi', vim.lsp.buf.implementation)
nmap('K', vim.lsp.buf.hover)

-- Navigate in diagnostics
nmap('<leader>k', vim.diagnostic.goto_prev)
nmap('<leader>j', vim.diagnostic.goto_next)

-- Rename
nmap('<F2>', vim.lsp.buf.rename)
