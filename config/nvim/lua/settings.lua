-----------------------
-- AutoCmd and stuff --
-----------------------

local autocmd = vim.api.nvim_create_autocmd

-- Vertically center document when entering insert mode
autocmd('InsertEnter', {command = 'norm zz'})


function HighlightTodo()
    vim.cmd [[ highlight Todo ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow" ]]
end

function HighlightExtraWhitespace()
    vim.cmd[[ highlight ExtraWhitespace ctermbg=red guibg=red ]]
    vim.cmd[[ match ExtraWhitespace /\s\+\%#\@<!$/ ]]
end

function Highlights()
    -- HighlightTodo()
    HighlightExtraWhitespace()
end

-- highlight trailing whitespace
-- local hl_group = vim.api.nvim_create_augroup(
--     'Highlights',
--     { clear = true }
-- )
autocmd(
    'ColorScheme',
    {callback = Highlights}
     -- group = hl_group}
)

-- Transparent background
-- vim.cmd[[ au ColorScheme * hi Normal ctermbg=none guibg=none ]]

-- Remove trailing whitespace on save
-- vim.cmd[[ autocmd BufWrite * %s/\s\+$//e ]]
autocmd('BufWrite', { command = "%s/\\s\\+$//e"})

---------------
-- Providers --
---------------

-- Disable useless providers
vim.g.loaded_ruby_provider = 0      -- Ruby
vim.g.loaded_perl_provider = 0      -- Perl
vim.g.loaded_python_provider = 0    -- Python 2

-- Python 3 provider

-- Detect if running nixos
os.execute("export DISTRO=$(cat /etc/os-release | grep -oP '(?<=^ID=).*')")
if (os.getenv('DISTRO') == 'nixos') then
    vim.g.python3_host_prog = '/etc/profiles/per-user/gaetan/bin/python3'
    vim.g.node_host_prog = '/etc/profiles/per-user/gaetan/bin/neovim-node-host'
end



--------------
-- Settings --
--------------

local o = vim.opt

o.updatetime = 100          -- Faster completion

-- Line numbers
o.relativenumber = true     -- Relative line numbers
o.number = true             -- display the absolute line number of the current line
o.hidden = true             -- keep closed buffer open in the background
o.clipboard = 'unnamedplus' -- Use system clipboard
o.mouse = 'a'               -- Enable mouse control
o.splitbelow = true         -- A new window is put below the current one
o.splitright = true         -- A new window is put right of the current one

o.swapfile = false          -- Disable the swap file
o.modeline = true           -- Tags such as 'vim:ft=sh'
o.modelines = 100           -- Sets the type of modelines
o.undofile = true           -- Automatically save and restore undo history
o.incsearch = true          -- Incremental search: show match for partly typed search command
o.smartcase = true          -- Override the 'ignorecase' option if the search
                            -- pattern contains upper case characters
o.scrolloff = 8             -- number of screen lines to show around the cursor
o.cursorline = false        -- Highlight the screen line of the cursor
o.cursorcolumn = false      -- Highlight the screen column of the cursor
o.signcolumn = 'yes'        -- whether to show the signcolumn
o.colorcolumn = '100'       -- columns to highlight
o.laststatus = 3            -- 0, 1 or 2; when to use a status line for the last window
o.encoding = 'utf-8'        -- encoding used to print the PostScript file for :hardcopy
o.termguicolors = true      -- Enables 24-bit RGB color in the |TUI|
o.spell = false             -- highlight spelling mistakes (local to window)

-- Set completeopt to have a better completion experience
o.completeopt = {'menu', 'menuone', 'noselect'}

-- Tab options
o.tabstop = 4               -- number of spaces a <Tab> in the text stands for (local to buffer)
o.shiftwidth = 4            -- number of spaces used for each step of (auto)indent (local to buffer)
o.softtabstop = 0           -- if non-zero, number of spaces to insert for a <Tab> (local to buffer)
o.expandtab = true          -- expand <Tab> to spaces in Insert mode (local to buffer)
o.smartindent = true        -- do clever autoindenting

o.textwidth = 100

-- Folding
o.foldmethod = 'indent'     -- Set folding type to indent
o.foldlevel = 99            -- Folds with a level higher than this number will be closed
