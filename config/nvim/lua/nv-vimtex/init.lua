vim.cmd('autocmd BufRead,BufNewFile *.tex set filetype=tex "| VimtexTocOpen')

-- autocmd FileType tex setl updatetime=1000
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

vim.g.vimtex_compiler_latexrun = {
    build_dir = '',
    options = {
        '-verbose-cmds',
        '--latex-args="-synctex=1"',
    },
}

vim.g.tex_flavor = 'latex'

vim.g.vimtex_compiler_progname = 'nvr'

vim.g.vimtex_quickfix_enabled = 1
vim.g.vimtex_quickfix_open_on_warning = 0

utils.nmap('<C-m>', ':VimtexTocToggle <CR>')
vim.cmd('autocmd FileType tex,latex nnoremap <buffer> m :VimtexView<CR>')


vim.cmd("autocmd BufReadPre *.tex let b:vimtex_main = 'main.tex'")

-- Spell check
vim.cmd('autocmd FileType tex,latex,markdown setlocal spell spelllang=en,fr')

-- folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'vimtex#fold#level(v:lnum)'
vim.o.foldtext = 'vimtex#fold#text()'


-- Compile on initialization, cleanup on quit
utils.create_augroup('vimtex_event_1',
                     {
                         { 'User', 'VimtexEventInitPost', 'call', 'vimtex#compiler#compile()' },
                         { 'User', 'VimtexEventQuit', 'call', 'vimtex#compiler#clean(0)' },
                     }
)
