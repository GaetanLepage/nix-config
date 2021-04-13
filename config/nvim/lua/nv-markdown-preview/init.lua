vim.api.nvim_set_keymap('n', '<Leader>m', ':MarkdownPreview<CR>', {noremap=true, silent=true})
vim.g.mkdp_browser = 'qutebrowser'

vim.g.mkdp_auto_start = 1
vim.g.mkdp_auto_stop = 1

-- vim.g.mkdp_echo_preview_url = 0

-- vim.g.mkdp_open_to_the_world = 1
-- vim.g.mkdp_open_ip = 'localhost'
-- vim.g.mkdp_port = 8080

-- vim.cmd [[
-- function! g:EchoUrl(url)
--     :echo a:url
-- endfunction
-- ]]

-- vim.g.mkdp_browserfunc = 'g:EchoUrl'
