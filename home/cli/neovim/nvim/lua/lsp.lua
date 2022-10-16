------------------
-- Key mappings --
------------------
local nmap = require 'utils'.nmap

nmap('gd', vim.lsp.buf.definition)
nmap('gD', vim.lsp.buf.references)
nmap('gt', vim.lsp.buf.type_definition)
nmap('gi', vim.lsp.buf.implementation)
nmap('K', vim.lsp.buf.hover)

-- Navigate in diagnostics
nmap('<leader>k', vim.diagnostic.goto_prev)
nmap('<leader>j', vim.diagnostic.goto_next)

-- Rename
nmap('<F2>', vim.lsp.buf.rename)


------------------------------------
-- nvim-cmp extended capabilities --
------------------------------------

-- The nvim-cmp almost supports LSP's capabilities so we advertise it to LSP servers.
local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)


------------------------------------------------
-- Individual language servers configurations --
------------------------------------------------

-- bash
require 'lspconfig'.bashls.setup {
    capabilities = capabilities
}

-- C / C++
require'lspconfig'.clangd.setup {
    capabilities = capabilities
}

-- LaTeX
require 'lspconfig'.texlab.setup {
    capabilities = capabilities
}

-- lua
require 'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            }
        }
    }
}

-- nix
require 'lspconfig'.rnix.setup {
    capabilities = capabilities
}

-- Python
require 'lspconfig'.pylsp.setup {
    capabilities = capabilities,
    enable = true,
    cmd = { 'pylsp' },
    -- cmd = { 'pylsp', '-vvv', '--log-file', 'pylsp.log' },
    settings = {
        pylsp = {
            configurationSources = {'flake8'},
            plugins = {
                flake8 = {
                    enabled = true,
                    maxLineLength = 100,
                    ignore = {
                        'D100', -- Missing docstring in public module
                        'D101', -- Missing docstring in public class
                        'D105', -- Missing docstring in magic method
                        'D107', -- Missing docstring in __init__
                        'D200', -- One-line docstring should fit on one line with quotes
                        'D205', -- 1 blank line required between summary line and description
                        'D400', -- First line should end with a period
                        'D402', -- First line should not be the function's "signature"
                        'D401', -- First line should be in imperative mood
                        'N812', -- Lowercase imported as non lowercase (prevents `import torch.functionnal as F`)
                        'W503'  -- line break before binary operator
                    },
                },
                pylint = {
                    enabled = false,
                    -- https://vald-phoenix.github.io/pylint-errors/
                    executable = 'pylint',
                    args = {
                        '--disable=' ..
                        'C0115,' ..      -- missing-class-docstring
                        'C0116,' ..      -- missing-function-docstring
                        'R0902,' ..      -- too-many-instance-attributes
                        'R0903,' ..      -- too-few-public-methods
                        'R0915'          -- too-many-statements
                    }
                },
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
                yapf = {
                    enabled = false
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
            }
        }
    }
}
