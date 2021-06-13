local nmap = utils.nmap

-- Find files using Telescope command-line sugar.
nmap('<Leader>ff', '<cmd>Telescope find_files<CR>')
nmap('<Leader>fg', '<cmd>Telescope live_grep<CR>')
nmap('<Leader>fb', '<cmd>Telescope bufferts<CR>')
nmap('<Leader>fh', '<cmd>Telescope help_tags<CR>')

-- FZF like bindings
nmap('<C-p>', '<cmd>Telescope git_files<CR>')
nmap('<Leader>p', '<cmd>Telescope oldfiles<CR>')
nmap('<Leader>a', '<cmd>Telescope live_grep<CR>')
