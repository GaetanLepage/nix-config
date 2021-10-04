local saga = require 'lspsaga'

-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

-- saga.init_lsp_saga {
--   your custom option here
-- }

--use default config
saga.init_lsp_saga()


------------------
-- Key mappings --
------------------
local nmap = require 'utils'.nmap

-- nmap('ca', ':Lspsaga code_action<CR>')
nmap('<leader>k', ':Lspsaga lsp_finder<CR>')
nmap('K', ':Lspsaga hover_doc<CR>')
-- nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
nmap('<C-k>', ':Lspsaga diagnostic_jump_prev<CR>')
nmap('<C-j>', ':Lspsaga diagnostic_jump_next<CR>')
-- scroll down hover doc or scroll in definition preview
nmap('<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>')
