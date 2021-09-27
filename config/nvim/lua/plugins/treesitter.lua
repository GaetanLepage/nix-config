require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'bash',
        'css',
        'html',
        'javascript',
        'latex',
        'lua',
        'python'
    },                          -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true           -- false will disable the whole extension
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,        -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    rainbow = {enable = false},
    refactor = {
        highlight_definitions = {enable = true},
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "<F2>",
            },
        },
    }
}
