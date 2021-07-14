require('plugins.telescope.bindings')

--------------
-- Bindings --
--------------
local nmap = require 'utils'.nmap

-- Find files using Telescope command-line sugar.
nmap('<leader>ff', '<cmd>Telescope find_files<CR>')
nmap('<leader>fg', '<cmd>Telescope live_grep<CR>')
nmap('<leader>fb', '<cmd>Telescope bufferts<CR>')
nmap('<leader>fh', '<cmd>Telescope help_tags<CR>')
nmap('<leader>fd', '<cmd>lua require("telescope.builtin").lsp_workspace_diagnostics()<CR>')

-- FZF like bindings
nmap('<C-p>', '<cmd>Telescope git_files<CR>')
nmap('<leader>p', '<cmd>Telescope oldfiles<CR>')
nmap('<leader>a', '<cmd>Telescope live_grep<CR>')


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
        file_ignore_patterns = {},
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
