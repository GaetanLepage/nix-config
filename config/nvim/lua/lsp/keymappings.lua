local nmap = require 'utils'.nmap

nmap('gd', ':lua vim.lsp.buf.definition()<CR>')
nmap('gD', ':lua vim.lsp.buf.references()<CR>')
nmap('gi', ':lua vim.lsp.buf.implementation()<CR>')
-- nmap('ca', ':Lspsaga code_action<CR>')
nmap('<leader>k', ':Lspsaga lsp_finder<CR>')
nmap('K', ':Lspsaga hover_doc<CR>')
-- nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
nmap('<C-k>', ':Lspsaga diagnostic_jump_prev<CR>')
nmap('<C-j>', ':Lspsaga diagnostic_jump_next<CR>')
-- scroll down hover doc or scroll in definition preview
nmap('<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>')
