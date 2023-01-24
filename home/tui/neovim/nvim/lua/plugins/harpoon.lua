require 'harpoon'.setup {
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        excluded_filetypes = { "harpoon" }
    }
}

-- Key mappings
local nmap = require 'utils'.nmap

-- Manage marks
local ui = require('harpoon.ui')
nmap('<leader>a',   require("harpoon.mark").add_file)
nmap('<C-e>',       ui.toggle_quick_menu)
nmap('<leader>tc',  require("harpoon.cmd-ui").toggle_quick_menu)

-- Navigate to existing marks
nmap('<C-j>',       function() ui.nav_file(1) end)
nmap('<C-k>',       function() ui.nav_file(2) end)
nmap('<C-l>',       function() ui.nav_file(3) end)
nmap('<CR>',        function() ui.nav_file(4) end)
