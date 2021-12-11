require('nvim_comment').setup()

local utils = require 'utils'
utils.nmap('<C-b>', ':CommentToggle<CR>')
utils.vmap('<C-b>', ':CommentToggle<CR>')
