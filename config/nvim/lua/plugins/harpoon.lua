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
nmap('<leader>a',
     ':lua require("harpoon.mark").add_file()<CR>')
nmap('<C-e>',
     ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
nmap('<leader>tc',
     ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')

-- Navigate to existing marks
nmap('<C-j>',
     ':lua require("harpoon.ui").nav_file(1)<CR>')
nmap('<C-k>',
     ':lua require("harpoon.ui").nav_file(2)<CR>')
nmap('<C-l>',
     ':lua require("harpoon.ui").nav_file(3)<CR>')
nmap('<C-m>',
     ':lua require("harpoon.ui").nav_file(4)<CR>')

-- Terminals
nmap('<leader>tu',
     ':lua require("harpoon.term").gotoTerminal(1)<CR>')
nmap('<leader>te',
     ':lua require("harpoon.term").gotoTerminal(2)<CR>')
nmap('<leader>cu',
     ':lua require("harpoon.term").sendCommand(1, 1)<CR>')
nmap('<leader>ce',
     ':lua require("harpoon.term").sendCommand(1, 2)<CR>')
