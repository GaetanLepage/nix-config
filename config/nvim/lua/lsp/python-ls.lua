-- pip install python-language-server
require'lspconfig'.pyls.setup(
    {
        enable = true,
        -- cmd = { 'pyls' },
        cmd = { 'pyls', '-vvv', '--log-file', 'pyls.log' },
        settings = {
            pyls = {
                configurationSources = {'flake8'},
                plugins = {
                    pyls_mypy = {
                        enabled = true,
                        live_mode = false
                    },
                    jedi_completion = {
                        enabled = true,
                        fuzzy = true
                    },
                    jedi_hover = {
                        enabled = true
                    },
                    jedi_references = {
                        enabled = true
                    },
                    jedi_signature_help = {
                        enabled = true
                    },
                    jedi_symbols = {
                        enabled = true,
                        all_scopes = true
                    },
                    pycodestyle = {
                        enabled = false
                    },
                    flake8 = {
                        enabled = true,
                        maxLineLength = 100,
                        ignore = {'D107', -- Missing docstring in __init__
                                  'D200', -- One-line docstring should fit on one line with quotes
                                  'D205', -- 1 blank line required between summary line and description
                                  'D400', -- First line should end with a period
                                  'D401'  -- First line should be in imperative mood
                                 },
                    },
                    yapf = {
                        enabled = false
                    },
                    pylint = {
                        enabled = true
                    },
                    pydocstyle = {
                        enabled = false
                    },
                    mccabe = {
                        enabled = false
                    },
                    preload = {
                        enabled = false
                    },
                    rope_completion = {
                        enabled = false
                    }
                }
            }
        },
        on_attach = on_attach
    }
)

-- npm i -g pyright
-- require'lspconfig'.pyright.setup{}

--   Commands:
--   - PyrightOrganizeImports: Organize Imports
--
--   Default Values:
--     cmd = { "pyright-langserver", "--stdio" }
--     filetypes = { "python" }
--     root_dir = function(filename)
--           return util.root_pattern(unpack(root_files))(filename) or
--                  util.path.dirname(filename)
--         end;
--     settings = {
--       python = {
--         analysis = {
--           autoSearchPaths = true,
--           useLibraryCodeForTypes = true
--         }
--       }
--     }
