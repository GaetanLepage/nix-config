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

-- LSP
use 'neovim/nvim-lspconfig'
use 'glepnir/lspsaga.nvim'
use 'folke/trouble.nvim'                -- Pretty list for showing diagnostics
use 'lervag/vimtex'                     -- LaTeX support
use 'hrsh7th/nvim-compe'                -- Autocomplete
use 'hrsh7th/vim-vsnip'
use 'hrsh7th/vim-vsnip-integ'
use 'honza/vim-snippets'

use {'iamcco/markdown-preview.nvim',    -- Markdown preview
     run = 'cd app && yarn install'}

-- Treesitter
use {'nvim-treesitter/nvim-treesitter', -- TreeSitter (for syntax highlighting and more)
     requires = 'nvim-treesitter/nvim-treesitter-refactor',
     run = ':TSUpdate'}

-- Icons
use 'kyazdani42/nvim-web-devicons'
use 'ryanoasis/vim-devicons' 			-- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.

-- Status Line and Bufferline
use 'hoob3rt/lualine.nvim'              -- The status line
use 'romgrk/barbar.nvim'                -- Tabline plugin

use {'nvim-telescope/telescope.nvim',   -- Telescope
     requires = {'nvim-lua/plenary.nvim',
                 'nvim-lua/popup.nvim'}}


use 'kyazdani42/nvim-tree.lua'          -- File tree
use 'gruvbox-community/gruvbox'         -- Colorcheme
use 'norcalli/nvim-colorizer.lua'       -- Preview colors directly from files

-- Git
use 'tpope/vim-fugitive' 				-- Git Fugitive
use 'airblade/vim-gitgutter'            -- Show a git diff in the sign column.
use 'TimUntersberger/neogit' 			-- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.

-- General Plugins
use 'windwp/nvim-autopairs' 			-- A minimalist autopairs for Neovim written in Lua
use 'kevinhwang91/nvim-bqf'             -- make Neovim's quickfix window better
use 'kevinhwang91/rnvimr'               -- Allows you to use Ranger in a floating window
use 'mhinz/vim-startify'                -- Start screen
use 'moll/vim-bbye'                     -- Delete buffers (close files) without closing your windows or messing up the layout
use 'voldikss/vim-floaterm'             -- A floating terminal window in neovim
use 'majutsushi/tagbar'                 -- Easy way to browse the tags of the current file and get an overview of its structure
use 'terrortylor/nvim-comment'          -- Offer key mapping to comment code
use 'bfredl/nvim-miniyank'

-- Python folding
use 'tmhedberg/SimpylFold'
