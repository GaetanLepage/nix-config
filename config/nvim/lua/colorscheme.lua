local hl = function(name, val)
    vim.api.nvim_set_hl(0, name, val)
end
-----------------------
-- Main color scheme --
-----------------------
vim.cmd('colorscheme gruvbox')

-----------------------
-- Custom highlights --
-----------------------

hl('Todo', { fg='Blue', bg='Yellow' })
vim.fn.matchadd('TODO', 'TODO')

-- Highlight extra whitespaces
hl('ExtraWhitespace', { bg='Red' })
vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')

-- Transparent background
-- hl(0, 'Normal', { bg='none' })
