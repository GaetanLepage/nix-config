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
        vimgrep_arguments = {
	        'rg',
	        '--no-heading',
	        '--with-filename',
	        '--line-number',
	        '--column',
	        '--smart-case'
    	},
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
	        horizontal = {mirror = false},
	        vertical = {mirror = false}
    	},
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {
            '^.git/',
            '^.mypy_cache/',
            '^__pycache__/',
            '^output/',
            '%.ipynb',
        },
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    }
}
