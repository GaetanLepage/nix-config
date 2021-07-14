local nmap = require 'utils'.nmap
nmap('<TAB>', ':BufferNext<CR>')
nmap('<S-TAB>', ':BufferPrevious<CR>')

nmap('<C-w>', ':BufferClose<CR>')
