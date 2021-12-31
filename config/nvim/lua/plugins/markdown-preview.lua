require 'utils'.nmap('<leader>m', ':MarkdownPreview<CR>')

vim.g.mkdp_browser = 'firefox'

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_stop = 0

-- vim.g.mkdp_echo_preview_url = 0

-- vim.g.mkdp_open_to_the_world = 1
-- vim.g.mkdp_open_ip = 'localhost'
-- vim.g.mkdp_port = 8081

-- vim.cmd [[
-- function! g:EchoUrl(url)
--     :echo a:url
-- endfunction
-- ]]

-- vim.g.mkdp_browserfunc = 'g:EchoUrl'
