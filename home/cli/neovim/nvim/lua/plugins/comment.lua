require 'nvim_comment'.setup()

local utils = require 'utils'
utils.nmap('<C-b>', ':CommentToggle<CR>')
utils.vmap('<C-b>', ':CommentToggle<CR>')

-- Manually set some comment strings
local commentstring_group = vim.api.nvim_create_augroup(
    'comment_string',
    { clear = true }
)

-- Nix comment string is a '#'
vim.api.nvim_create_autocmd(
    {'BufEnter', 'BufFilePost'},
    {
        pattern = '*.nix',
        callback = function()
            vim.api.nvim_buf_set_option(0, 'commentstring', '# %s')
        end,
        group = commentstring_group
    }
)
