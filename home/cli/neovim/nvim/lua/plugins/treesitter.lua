require 'nvim-treesitter.configs'.setup {

    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        'bash',
        'c',
        'html',
        'help',         -- neovim help
        'javascript',
        'latex',
        'lua',
        'nix',
        'norg',
        'python',
        'rust'
    },

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    indent = { enable = true },

    refactor = {
        highlight_definitions = {
            -- Highlights definition and usages of the current symbol under the cursor.
            enable = true
        }
    }
}
