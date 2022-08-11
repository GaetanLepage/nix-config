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

        ["core.norg.concealer"] = { }
    }
}
