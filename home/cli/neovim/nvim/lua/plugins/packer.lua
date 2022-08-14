local fn = vim.fn
local packer = nil


-- Install packer if necessary
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.api.nvim_command 'packadd packer.nvim'
end


-- Register plugins
if packer == nil then
    packer = require 'packer'
    packer.init()
end

local use = packer.use
packer.reset()
use 'wbthomason/packer.nvim'            -- Packer can manage itself as an optional plugin

---------------
-- LANGUAGES ---------------------------------------------------------------------------------------
---------------
-- LSP
use 'neovim/nvim-lspconfig'             -- A collection of common configurations for the built-in
                                        --  language server client.
use 'folke/trouble.nvim'                -- Pretty list for showing diagnostics
use 'lervag/vimtex'                     -- LaTeX support

-- Completion
use 'hrsh7th/nvim-cmp'                  -- Completion engine
use 'hrsh7th/cmp-buffer'                -- nvim-cmp source for buffer words
use 'hrsh7th/cmp-path'                  -- nvim-cmp source for paths
use 'hrsh7th/cmp-nvim-lsp'              -- Nvim-cmp source for neovim builtin LSP client
use {'tzachar/cmp-tabnine',             -- TabNine
     run = './install.sh' }

use 'onsails/lspkind-nvim'              -- vscode-like pictograms to neovim built-in lsp

-- Python folding
use 'tmhedberg/SimpylFold'

-- Snippets
use 'L3MON4D3/LuaSnip'                  -- snippet engine
use 'saadparwaiz1/cmp_luasnip'          -- luasnip completion source for nvim-cmp
use 'honza/vim-snippets'                -- snippets files for various programming languages.

use {'iamcco/markdown-preview.nvim',    -- Markdown preview
     run = 'cd app && yarn install'}


use {'nvim-treesitter/nvim-treesitter', -- Treesitter (for syntax highlighting and more)
     run = ':TSUpdate'}
use 'nvim-treesitter/nvim-treesitter-refactor'

--------
-- UI ----------------------------------------------------------------------------------------------
--------
-- Requirements:
use 'kyazdani42/nvim-web-devicons'      -- for lualine, barbar, nvim-tree...
use 'nvim-lua/plenary.nvim'             -- for harpoon and telescope

-- Status Line and Bufferline
use 'hoob3rt/lualine.nvim'              -- The status line
use 'romgrk/barbar.nvim'                -- Tabline plugin

use 'nvim-telescope/telescope.nvim'     -- Telescope
use 'ThePrimeagen/harpoon'              -- Harpoon
use 'kyazdani42/nvim-tree.lua'          -- File tree

use 'ellisonleao/gruvbox.nvim'          -- Colorcheme
use 'norcalli/nvim-colorizer.lua'       -- Preview colors directly from files

use 'airblade/vim-gitgutter'            -- Show a git diff in the sign column.

----------
-- Misc --------------------------------------------------------------------------------------------
----------
-- General Plugins
use 'windwp/nvim-autopairs'             -- A minimalist autopairs for Neovim written in Lua
use 'kevinhwang91/nvim-bqf'             -- Make Neovim's quickfix window better
use 'mhinz/vim-startify'                -- Start screen
use 'moll/vim-bbye'                     -- Delete buffers (close files) without closing your windows
                                        --  or messing up the layout
use 'voldikss/vim-floaterm'             -- A floating terminal window in neovim
use 'preservim/tagbar'                  -- Easy way to browse the tags of the current file and get
                                        --  an overview of its structure
use 'terrortylor/nvim-comment'          -- Offer key mapping to comment code
use 'nvim-neorg/neorg'                  -- Orgmode for neovim
