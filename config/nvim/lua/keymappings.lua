local nmap = utils.nmap
local vmap = utils.vmap
local xmap = utils.xmap


nmap('<Space>', '<NOP>')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- no hl
--map('n', '<Leader>h', ':set hlsearch!<CR>', {noremap=true, silent=true})

-- Esc to clear search results
nmap('<esc>', ':noh<CR>')

-- explorer
-- map('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap=true, silent=true})
nmap('<Leader>n', ':NvimTreeToggle<CR>')

-- fix Y behaviour
nmap('Y', 'y$')

-- back and fourth between the two most recent files
nmap('<C-c>', ':b#<CR>')
nmap('<Leader>c', ':b#<CR>')

-- close by Ctrl+x
nmap('<C-x>', ':close<CR>')

-- save by Ctrl+s
nmap('<C-s>', ':w<CR>')

-- better window movement
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- resize with arrows
nmap('<C-Up>', ':resize -2<CR>')
nmap('<C-Down>', ':resize +2<CR>')
nmap('<C-Left>', ':vertical resize +2<CR>')
nmap('<C-Right>', ':vertical resize -2<CR>')


-- better indenting
vmap('<', '<gv')
vmap('>', '>gv')

-- Tab switch buffer
-- map('n', '<TAB>', ':bnext<CR>', {noremap=true, silent=true})
-- map('n', '<S-TAB>', ':bprevious<CR>', {noremap=true, silent=true})

-- Move selected line / block of text in visual mode
xmap('K', ':move \'<-2<CR>gv-gv')
xmap('J', ':move \'>+1<CR>gv-gv')
-- some brilliant line movement mappings from junegunn ---"
-- move current line up/down
-- M = Alt key
nmap('<M-k>', ':move-2<CR>')
nmap('<M-j>', ':move+<CR>')

-- Better nav for omnicomplete
vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

-- TAB Complete
-- map('i', '<expr><TAB>', 'pumvisible() ? \"\\<C-n>\" : \"\\<TAB>\"', { noremap=true, silent=true })

-- TODO check if this is useful (Gaetan)
-- vim.cmd([[
--     map p <Plug>(miniyank-autoput)
--     map P <Plug>(miniyank-autoPut)
--     map <leader>n <Plug>(miniyank-cycle)
--     map <leader>N <Plug>(miniyank-cycleback)
-- ]])
