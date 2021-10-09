require('nvim_comment').setup()

local utils = require 'utils'
local nmap = utils.nmap
local vmap = utils.vmap

nmap('<C-b>', ':CommentToggle<CR>')
vmap('<C-b>', ':CommentToggle<CR>')
