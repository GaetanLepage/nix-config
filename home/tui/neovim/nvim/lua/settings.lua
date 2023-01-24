-----------------------
-- AutoCmd and stuff --
-----------------------

local autocmd = vim.api.nvim_create_autocmd

-- Vertically center document when entering insert mode
autocmd('InsertEnter', { command = 'norm zz' })

-- Remove trailing whitespace on save
autocmd('BufWrite', { command = "%s/\\s\\+$//e"})

-- Open help in a vertical split
autocmd('FileType', { pattern = "help", command = "wincmd L"})

---------------
-- Providers --
---------------

-- Disable useless providers
vim.g.loaded_ruby_provider = 0      -- Ruby
vim.g.loaded_perl_provider = 0      -- Perl
vim.g.loaded_python_provider = 0    -- Python 2

-- Specify paths to some providers
vim.g.python3_host_prog = '/etc/profiles/per-user/gaetan/bin/python3'
vim.g.node_host_prog = '/etc/profiles/per-user/gaetan/bin/neovim-node-host'


--------------
-- Settings --
--------------

vim.g.do_filetype_lua = 1   -- Enable filetype matching using fast `filetype.lua`

local o = vim.opt

o.updatetime = 100          -- Faster completion

-- Line numbers
o.relativenumber = true     -- Relative line numbers
o.number = true             -- Display the absolute line number of the current line
o.hidden = true             -- Keep closed buffer open in the background
o.clipboard = 'unnamedplus' -- Use system clipboard
o.mouse = 'a'               -- Enable mouse control
o.splitbelow = true         -- A new window is put below the current one
o.splitright = true         -- A new window is put right of the current one

o.swapfile = false          -- Disable the swap file
o.modeline = true           -- Tags such as 'vim:ft=sh'
o.modelines = 100           -- Sets the type of modelines
o.undofile = true           -- Automatically save and restore undo history
o.incsearch = true          -- Incremental search: show match for partly typed search command
o.ignorecase = true         -- When the search query is lower-case, match both lower and upper-case
                            -- patterns
o.smartcase = true          -- Override the 'ignorecase' option if the search pattern contains upper
                            -- case characters
o.scrolloff = 8             -- Number of screen lines to show around the cursor
o.cursorline = false        -- Highlight the screen line of the cursor
o.cursorcolumn = false      -- Highlight the screen column of the cursor
o.signcolumn = 'yes'        -- Whether to show the signcolumn
o.colorcolumn = '100'       -- Columns to highlight
o.laststatus = 3            -- When to use a status line for the last window
o.fileencoding = 'utf-8'    -- File-content encoding for the current buffer
o.termguicolors = true      -- Enables 24-bit RGB color in the |TUI|
o.spell = false             -- Highlight spelling mistakes (local to window)

-- Set completeopt to have a better completion experience
o.completeopt = {'menu', 'menuone', 'noselect'}

-- Tab options
o.tabstop = 4               -- Number of spaces a <Tab> in the text stands for (local to buffer)
o.shiftwidth = 4            -- Number of spaces used for each step of (auto)indent (local to buffer)
o.softtabstop = 0           -- If non-zero, number of spaces to insert for a <Tab> (local to buffer)
o.expandtab = true          -- Expand <Tab> to spaces in Insert mode (local to buffer)
o.autoindent = true         -- Do clever autoindenting

o.textwidth = 100           -- Maximum width of text that is being inserted.  A longer line will be
                            -- broken after white space to get this width.

-- Folding
o.foldmethod = 'expr'     -- Set folding type to indent
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldlevel = 99            -- Folds with a level higher than this number will be closed
