-- Color table for highlights
local colors = {
    bg = '#202328',
    fg = '#bbc2cf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67'
}

local conditions = {
    buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
}


require 'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {},
        globalstatus = true
    },


    sections = {
        -- +-------------------------------------------------+
        -- | A | B | C                             X | Y | Z |
        -- +-------------------------------------------------+
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {
            'filename',
            {
                'branch',
                icon = '',
                condition = conditions.check_git_workspace,
                color = {fg = colors.violet, gui = 'bold'}
            },
            {
                'diff',
                colored = true,

                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.orange },
                    removed = {fg = colors.red }
                },

                -- Is it me or the symbol for modified is really weird ?
                symbols = {added = ' ', modified = '柳', removed = ' '},
            }
        },
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_diagnostic'},
                symbols = {error = ' ', warn = ' ', info = ' '},
                color_error = colors.red,
                color_warn = colors.yellow,
                color_info = colors.cyan
            },
            {
                function()
                    local msg = ''
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then return msg end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = '',
                color = {fg = '#ffffff',
                         gui = 'bold'}
            },
            'encoding',
            'fileformat',
            'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },

    tabline = {},
    extensions = {}
}