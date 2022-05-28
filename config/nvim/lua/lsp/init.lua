-- Keymappings
require 'lsp.keymappings'

-- Source each LSP server configuration
require 'lsp.bash'
require 'lsp.c'
require 'lsp.julia'
require 'lsp.latex'
require 'lsp.lua'
require 'lsp.nix'
require 'lsp.python'
require 'lsp.typescript'


-- scroll up hover doc
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

local function highlight_symbol_under_cursor(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then

        vim.api.nvim_set_hl(
            0, 'LspReferenceRead',
            { cterm='bold', ctermbg='red', guibg='LightYellow' }
        )
        vim.api.nvim_set_hl(
            0, 'LspReferenceText',
            { cterm='bold', ctermbg='red', guibg='LightYellow' }
        )
        vim.api.nvim_set_hl(
            0, 'LspReferenceWrite',
            { cterm='bold', ctermbg='red', guibg='LightYellow' }
        )

        vim.api.nvim_create_augroup('lsp_document_highlight', {})
        vim.api.nvim_create_autocmd(
            {
                'CursorHold',
                'CursorHoldI'
            },
            {
                group = 'lsp_document_highlight',
                buffer = 0,
                callback = vim.lsp.buf.document_highlight
            }
        )
        vim.api.nvim_create_autocmd(
            'CursorMoved',
            {
                group = 'lsp_document_highlight',
                buffer = 0,
                callback = vim.lsp.buf.clear_references
            }
        )

    end
end

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    highlight_symbol_under_cursor(client, bufnr)
end

return lsp_config
