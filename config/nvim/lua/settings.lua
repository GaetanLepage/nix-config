-- vim.cmd('set iskeyword+=-')                      --treat dash separated words as a word text object"
-- vim.cmd('set shortmess+=c')                     --Don't pass messages to |ins-completion-menu|.
-- vim.o.hidden=true                               --Required to keep multiple buffers open multiple buffers
-- vim.wo.wrap=false                               --Display long lines as just one line
-- vim.cmd('set whichwrap+=<,>,[,],h,l')
-- vim.o.pumheight=10                              --Makes popup menu smaller
-- vim.o.fileencoding="utf-8"                      --The encoding written to file
-- vim.o.cmdheight=2                             --More space for displaying messages
-- vim.o.mouse="a"                                 --Enable your mouse
-- vim.o.splitbelow=true                           --Horizontal splits will automatically be below
-- vim.o.termguicolors=true
-- vim.o.splitright=true                           --Vertical splits will automatically be to the right
-- vim.o.t_Co="256"                                --Support 256 colors
-- vim.o.conceallevel=0                          --So that I can see `` in markdown files
-- vim.cmd('set ts=4')                               --Insert 2 spaces for a tab
-- vim.cmd('set sw=4')                            --Change the number of space characters inserted for indentation
-- vim.bo.expandtab=true                           --Converts tabs to spaces
-- vim.wo.number = true
-- vim.wo.cursorline=true                          --Enable highlighting of the current line
-- vim.o.showtabline=2                           --Always show tabs
-- vim.o.showmode=false                            --We don't need to see things like -- INSERT -- anymore
-- vim.o.backup=false                              --This is recommended by coc
-- vim.o.writebackup=false                         --This is recommended by coc
-- vim.wo.signcolumn="yes"                         --Always show the signcolumn, otherwise it would shift the text each time
-- vim.o.updatetime=300                            --Faster completion
-- vim.o.timeoutlen=100                          --By default timeoutlen is 1000 ms
-- vim.o.clipboard="unnamedplus"                   --Copy paste between vim and everything else
-- vim.o.guifont="JetBrainsMono\\ Nerd\\ Font\\ Mono:h18"

-- AutoCmd and stuff

-- Vertically center document when entering insert mode
vim.cmd[[ autocmd InsertEnter * norm zz ]]


function HighlightTodo()
    vim.cmd [[ highlight Todo ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow" ]]
end

function HighlightExtraWhitespace()
    vim.cmd[[ highlight ExtraWhitespace ctermbg=red guibg=red ]]
    vim.cmd[[ match ExtraWhitespace /\s\+\%#\@<!$/ ]]
end

function Highlights()
    HighlightTodo()
    HighlightExtraWhitespace()
end

-- highlight trailing whitespace (TODO fix)
utils.create_augroup('Highlights',
                     {
                         {"ColorScheme", "*", "lua Highlights()"}
                     }
)

-- Remove trailing whitespace on save
vim.cmd[[ autocmd BufWrite * %s/\s\+$//e ]]

local o = vim.o
local wo = vim.wo
local bo = vim.bo


o.updatetime=300            --Faster completion

-- Line numbers
wo.relativenumber=true      -- Relative line numbers
wo.number=true              -- display the absolute line number of the current line
o.hidden=true               -- keep closed buffer open in the background
o.clipboard="unnamedplus"   -- Use system clipboard
o.mouse="a"                 -- Enable mouse control
o.splitbelow=true           -- A new window is put below the current one
o.splitright=true           -- A new window is put right of the current one
--o.errorbells=false        -- Disable the error bell for errors
vim.cmd [[
    set noswapfile
    set modeline
]]
-- bo.swapfile=false           -- Disable the swap file
-- bo.modeline=true            -- Tags such as 'vim:ft=sh'
o.modelines=100             -- Sets the type of modelines
o.undofile=true             -- Automatically save and restore undo history
o.incsearch=true            -- Incremental search: show match for partly typed search command
o.smartcase=true            -- Override the 'ignorecase' option if the search pattern contains upper case characters
o.scrolloff=8               -- number of screen lines to show around the cursor
--set cursorline            -- Highlight the screen line of the cursor
--set cursorcolumn          -- Highlight the screen column of the cursor
wo.signcolumn="yes"         -- whether to show the signcolumn
wo.colorcolumn="100"        -- columns to highlight
o.laststatus=2              -- 0, 1 or 2; when to use a status line for the last window
o.encoding="utf-8"          -- encoding used to print the PostScript file for :hardcopy
o.termguicolors=true        -- Enables 24-bit RGB color in the |TUI|
wo.spell=false              -- highlight spelling mistakes (local to window)
--syntax on                 -- Enable syntax highlighting

-- Set completeopt to have a better completion experience
--vim.o.completeopt=menuone,noinsert,noselect

-- Tab options
vim.cmd [[
    set tabstop=4
    set shiftwidth=4
    set softtabstop=0
    set expandtab
    set smartindent
]]
-- TODO set this when teej will have fixed the problem on neovim (https://github.com/neovim/neovim/issues/12978)
--bo.tabstop=4                -- number of spaces a <Tab> in the text stands for (local to buffer)
--bo.shiftwidth=4             -- number of spaces used for each step of (auto)indent (local to buffer)
--bo.softtabstop=0            -- if non-zero, number of spaces to insert for a <Tab> (local to buffer)
--bo.expandtab=true           -- expand <Tab> to spaces in Insert mode (local to buffer)
--bo.smartindent=true         -- do clever autoindenting

-- Folding
wo.foldmethod="indent" 	    -- Set folding type to indent
wo.foldlevel=99             -- Folds with a level higher than this number will be closed
