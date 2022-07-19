--------------
-- Bindings --
--------------
local nmap = require 'utils'.nmap

local builtin = require 'telescope.builtin'

-- Find files using Telescope command-line sugar.
nmap('<leader>ff', builtin.find_files)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fb', builtin.buffers)
nmap('<leader>fh', builtin.help_tags)
nmap('<leader>fd',
     function()
        builtin.diagnostics({bufnr = 0})
     end
)

-- FZF like bindings
nmap('<C-p>', builtin.git_files)
nmap('<leader>p', builtin.oldfiles)
nmap('<C-f>', builtin.live_grep)


-------------------
-- Configuration --
-------------------
require 'telescope'.setup {
    defaults = {
        file_ignore_patterns = {
            '^.git/',
            '^.mypy_cache/',
            '^__pycache__/',
            '^output/',
            '^data/',
            '%.ipynb',
        },
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    }
}
