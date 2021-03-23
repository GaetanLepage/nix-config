local map = vim.api.nvim_set_keymap

-- Find files using Telescope command-line sugar.
map('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', {noremap=true, silent=true})
map('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', {noremap=true, silent=true})
map('n', '<Leader>fb', '<cmd>Telescope bufferts<CR>', {noremap=true, silent=true})
map('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', {noremap=true, silent=true})

-- FZF like bindings
map('n', '<C-p>', '<cmd>Telescope git_files<CR>', {noremap=true, silent=true})
map('n', '<Leader>p', '<cmd>Telescope oldfiles<CR>', {noremap=true, silent=true})
map('n', '<Leader>a', '<cmd>Telescope live_grep<CR>', {noremap=true, silent=true})
