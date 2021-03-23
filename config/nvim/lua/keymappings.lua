local map = vim.api.nvim_set_keymap


map('n', '<Space>', '<NOP>', {noremap=true, silent=true})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- no hl
--map('n', '<Leader>h', ':set hlsearch!<CR>', {noremap=true, silent=true})

-- Esc to clear search results
map('n', '<esc>', ':noh<CR>', {noremap=true, silent=true})

-- explorer
map('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap=true, silent=true})

-- fix Y behaviour
map('n', 'Y', 'y$', {noremap=true, silent=true})

-- quit by Ctrl+w
-- map('n', '<C-w>', ':bd<CR>', {noremap=true, silent=true})

-- save by Ctrl+s
map('n', '<C-s>', ':w<CR>', {noremap=true, silent=true})

-- better window movement
map('n', '<C-h>', '<C-w>h', {silent=true, noremap=true})
map('n', '<C-j>', '<C-w>j', {silent=true, noremap=true})
map('n', '<C-k>', '<C-w>k', {silent=true, noremap=true})
map('n', '<C-l>', '<C-w>l', {silent=true, noremap=true})

-- resize with arrows
map('n', '<C-Up>', ':resize -2<CR>', {noremap=true, silent=true})
map('n', '<C-Down>', ':resize +2<CR>', {noremap=true, silent=true})
map('n', '<C-Left>', ':vertical resize +2<CR>', {noremap=true, silent=true})
map('n', '<C-Right>', ':vertical resize -2<CR>', {noremap=true, silent=true})


-- better indenting
map('v', '<', '<gv', {noremap=true, silent=true})
map('v', '>', '>gv', {noremap=true, silent=true})

-- Tab switch buffer
-- map('n', '<TAB>', ':bnext<CR>', {noremap=true, silent=true})
-- map('n', '<S-TAB>', ':bprevious<CR>', {noremap=true, silent=true})

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv', {noremap=true, silent=true})
map('x', 'J', ':move \'>+1<CR>gv-gv', {noremap=true, silent=true})
-- some brilliant line movement mappings from junegunn ---"
-- move current line up/down
-- M = Alt key
map('n', '<M-k>', ':move-2<CR>', {noremap=true, silent=true})
map('n', '<M-j>', ':move+<CR>', {noremap=true, silent=true})

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
