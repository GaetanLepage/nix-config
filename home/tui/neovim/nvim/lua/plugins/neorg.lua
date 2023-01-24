vim.o.conceallevel = 2
vim.o.concealcursor = 'nc'

require 'neorg'.setup {
    load = {
        ["core.defaults"] = {},

        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.unmap('norg', 'n', '<C-s>')
                end
            }
        },

        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/notes"
                }
            }
        },

        ["core.norg.concealer"] = { },

        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp"
            }
        }
    }
}
