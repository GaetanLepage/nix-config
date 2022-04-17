-----------------------
-- Main color scheme --
-----------------------
vim.cmd('colorscheme gruvbox')

-----------------------
-- Custom highlights --
-----------------------

vim.api.nvim_set_hl(0, 'Todo', { fg='Blue', bg='Yellow' })

-- Highlight extra whitespaces
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg='Red' })
vim.cmd[[ match ExtraWhitespace /\s\+\%#\@<!$/ ]]

-- Transparent background
-- vim.api.nvim_set_hl(0, 'Normal', { bg='none' })
