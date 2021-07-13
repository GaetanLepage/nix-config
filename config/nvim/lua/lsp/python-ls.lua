local util = require'lspconfig'.util
-- pip install python-lsp-server
-- pip install mypy-ls
require'lspconfig'.pylsp.setup(
    {
        enable = true,
        cmd = { 'pylsp' },
        -- cmd = { 'pylsp', '-vvv', '--log-file', 'pylsp.log' },
        settings = {
            pylsp = {
                configurationSources = {'flake8'},
                plugins = {
                    pylsp_mypy = {
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
                        ignore = {'D105', -- Missing docstring in magic method
                                  'D107', -- Missing docstring in __init__
                                  'D200', -- One-line docstring should fit on one line with quotes
                                  'D205', -- 1 blank line required between summary line and description
                                  'D400', -- First line should end with a period
                                  'D402', -- First line should not be the function's "signature"
                                  'D401', -- First line should be in imperative mood
                                  'W503'  -- line break before binary operator
                                 },
                    },
                    yapf = {
                        enabled = false
                    },
                    pylint = {
                        enabled = true
                    },
                    pyflakes = {
                        enabled = false
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
