-----------------------
-- Main color scheme --
-----------------------
vim.cmd('colorscheme gruvbox')

-----------------------
-- Custom highlights --
-----------------------

vim.api.nvim_set_hl(0, 'Todo', { fg='Blue', bg='Yellow' })
vim.fn.matchadd('TODO', 'TODO')

-- Highlight extra whitespaces
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg='Red' })
vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')

-- Transparent background
-- vim.api.nvim_set_hl(0, 'Normal', { bg='none' })
