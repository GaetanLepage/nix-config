local autocmd = vim.api.nvim_create_autocmd

autocmd(
    {'BufRead', 'BufNewFile'},
    {
        pattern = '*.tex',
        command = 'set filetype=tex "| VimtexTocOpen'
    }
)

vim.g.vimtex_view_method = 'zathura'

-- TOC settings
vim.g.vimtex_toc_config = {
    name = 'TOC',
    layers = "['content', 'todo']",
    resize = 1,
    split_width = 50,
    todo_sorted = 0,
    show_help = 1,
    show_numbers = 1,
    mode = 2
}


-- Ignore undesired errors and warnings
vim.g.vimtex_quickfix_ignore_filters = {
    'Underfull',
    'Overfull',
    'specifier changed to',
    'Token not allowed in a PDF string',
}

vim.g.tex_flavor = 'latex'

vim.g.vimtex_compiler_progname = 'nvr'

vim.g.vimtex_quickfix_enabled = 1
vim.g.vimtex_quickfix_open_on_warning = 0

-- utils.nmap('<C-m>', ':VimtexTocToggle <CR>')
autocmd(
    'FileType',
    {
        pattern = 'tex,latex',
        command = 'nnoremap <buffer> m :VimtexView<CR>'
    }
)


autocmd(
    'BufReadPre',
    {
        pattern = '*.tex',
        command = "let b:vimtex_main = 'main.tex'"
    }
)

-- Spell check
autocmd(
    'FileType',
    {
        pattern = 'tex,latex,markdown',
        command = "setlocal spell spelllang=en,fr"
    }
)

-- folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'vimtex#fold#level(v:lnum)'
vim.o.foldtext = 'vimtex#fold#text()'


-- Compile on initialization, cleanup on quit
local vimtex_augroup = vim.api.nvim_create_augroup(
    'vimtex_event_1',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    'User',
    {
        pattern = 'VimtexEventInitPost',
        callback = 'vimtex#compiler#compile',
        group = vimtex_augroup
    }
)
vim.api.nvim_create_autocmd(
    'User',
    {
        pattern = 'VimtexEventQuit',
        command = 'call vimtex#compiler#clean(0)',
        group = vimtex_augroup
    }
)
