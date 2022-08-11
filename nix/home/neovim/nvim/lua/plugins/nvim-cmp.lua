vim.o.completeopt = "menuone,menuone,noselect"


local cmp = require'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            -- For `vsnip` user.
            -- vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` user.
            require 'luasnip'.lsp_expand(args.body)

            -- For `ultisnips` user.
            -- vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },

    -- List of sources for completion
    -- The order **matters** as it decides the priority of suggestions.
    sources = {
        { name = 'path' },

        { name = 'nvim_lsp' },

        -- TabNine
 	    { name = 'cmp_tabnine' },

        -- Snippets
        { name = 'luasnip' },

        { name = 'buffer' },
    },

    formatting = {
        -- Youtube: How to set up nice formatting for your sources.
        format = require 'lspkind'.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                gh_issues = "[issues]",
                tn = "[TabNine]",
            },
        },
    },

    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,

        -- Let's play with this for a day or two
        ghost_text = true,
    }
}
