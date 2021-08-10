local utils = require 'utils'
local nmap = utils.nmap
local vmap = utils.vmap
local xmap = utils.xmap


nmap('<Space>', '<NOP>')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- no hl
-- nmap('<leader>h', ':set hlsearch!<CR>')

-- Esc to clear search results
nmap('<esc>', ':noh<CR>')

-- explorer
nmap('<leader>n', ':NvimTreeToggle<CR>')

-- fix Y behaviour
nmap('Y', 'y$')

-- Enter key is useless anyway
nmap('<CR>', ':')

-- back and fourth between the two most recent files
nmap('<C-c>', ':b#<CR>')
nmap('<leader>c', ':b#<CR>')

-- close by Ctrl+x
nmap('<C-x>', ':close<CR>')

-- save by Ctrl+s
nmap('<C-s>', ':w<CR>')

-- better window movement
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')
nmap('<leader>h', '<C-w>h')
nmap('<leader>j', '<C-w>j')
nmap('<leader>k', '<C-w>k')
nmap('<leader>l', '<C-w>l')

-- resize with arrows
nmap('<C-Up>', ':resize -2<CR>')
nmap('<C-Down>', ':resize +2<CR>')
nmap('<C-Left>', ':vertical resize +2<CR>')
nmap('<C-Right>', ':vertical resize -2<CR>')

-- better indenting
vmap('<', '<gv')
vmap('>', '>gv')

-- Tab switch buffer
-- nmap('<TAB>', ':bnext<CR>')
-- nmap('<S-TAB>', ':bprevious<CR>')

-- move selected line / block of text in visual mode
xmap('K', ':move \'<-2<CR>gv-gv')
xmap('J', ':move \'>+1<CR>gv-gv')

-- move current line up/down
-- M = Alt key
nmap('<M-k>', ':move-2<CR>')
nmap('<M-j>', ':move+<CR>')

nmap('<leader>rp', ':!remi push<CR>')
