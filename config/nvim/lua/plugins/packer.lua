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
use 'tami5/lspsaga.nvim'                -- A light-weight lsp plugin based on neovim built-in lsp
                                        --  with highly a performant UI.
use 'folke/trouble.nvim'                -- Pretty list for showing diagnostics
use 'lervag/vimtex'                     -- LaTeX support

-- Completion
use 'hrsh7th/nvim-cmp'                  -- Completion engine
use 'hrsh7th/cmp-buffer'                -- nvim-cmp source for buffer words
use 'hrsh7th/cmp-nvim-lsp'              -- Nvim-cmp source for neovim builtin LSP client
use {                                   -- TabNine
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = {
        'hrsh7th/nvim-cmp'
    }
}

-- Python folding
use 'tmhedberg/SimpylFold'

-- Snippets
use 'L3MON4D3/LuaSnip'                  -- snippet engine
use 'saadparwaiz1/cmp_luasnip'          -- luasnip completion source for nvim-cmp
use 'honza/vim-snippets'                -- snippets files for various programming languages.

use {'iamcco/markdown-preview.nvim',    -- Markdown preview
     run = 'cd app && yarn install'}

-- Treesitter (for syntax highlighting and more)
use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
        'nvim-treesitter/nvim-treesitter-refactor'
    },
    run = ':TSUpdate'
}

--------
-- UI ----------------------------------------------------------------------------------------------
--------
-- Status Line and Bufferline
use 'hoob3rt/lualine.nvim'              -- The status line
use {                                   -- Tabline plugin
    'romgrk/barbar.nvim',
    requires = {
        'kyazdani42/nvim-web-devicons'
    }
}

use {
    'nvim-telescope/telescope.nvim',    -- Telescope
    requires = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim'
    }
}

use {
    'ThePrimeagen/harpoon',             -- Harpoon
    requires = {
        'nvim-lua/plenary.nvim'
    }
}

use {
    'kyazdani42/nvim-tree.lua',         -- File tree
    requires = {
        'kyazdani42/nvim-web-devicons',
    }
}
use 'gruvbox-community/gruvbox'         -- Colorcheme
use 'norcalli/nvim-colorizer.lua'       -- Preview colors directly from files

---------
-- Git ---------------------------------------------------------------------------------------------
---------
use 'tpope/vim-fugitive'                -- Git Fugitive
use 'airblade/vim-gitgutter'            -- Show a git diff in the sign column.

----------
-- Misc --------------------------------------------------------------------------------------------
----------
-- General Plugins
use 'windwp/nvim-autopairs'             -- A minimalist autopairs for Neovim written in Lua
use 'kevinhwang91/nvim-bqf'             -- Make Neovim's quickfix window better
use 'kevinhwang91/rnvimr'               -- Allows you to use Ranger in a floating window
use 'mhinz/vim-startify'                -- Start screen
use 'moll/vim-bbye'                     -- Delete buffers (close files) without closing your windows
                                        --  or messing up the layout
use 'voldikss/vim-floaterm'             -- A floating terminal window in neovim
use 'majutsushi/tagbar'                 -- Easy way to browse the tags of the current file and get
                                        --  an overview of its structure
use 'terrortylor/nvim-comment'          -- Offer key mapping to comment code
