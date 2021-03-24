local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    -- Quality of life improvements
    use 'norcalli/nvim_utils'

    -- LaTeX
    use 'lervag/vimtex'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'kosayoda/nvim-lightbulb'
    use 'mfussenegger/nvim-jdtls'

    -- Autocomplete
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'honza/vim-snippets'
    --use 'cstrap/python-snippets'
    -- use 'ylcnfrht/vscode-python-snippet-pack'
    -- use 'golang/vscode-go'
    -- use 'rust-lang/vscode-rust'
    -- use 'SirVer/ultisnips'
    -- use 'norcalli/snippets.nvim'

    use {'iamcco/markdown-preview.nvim',
         run = 'cd app && yarn install'}

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter',
    	 run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'p00f/nvim-ts-rainbow' 				-- Rainbow parentheses for neovim using tree-sitter. Needs nvim-treesitter.

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons' 			-- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.

    -- Status Line and Bufferline
    use 'glepnir/galaxyline.nvim'           -- The status line
    use 'romgrk/barbar.nvim'                -- Tabline plugin

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Color
    use 'gruvbox-community/gruvbox'
    --use 'christianchiarulli/nvcode-color-schemes.vim'
    use 'norcalli/nvim-colorizer.lua'

    -- Git
    use 'tpope/vim-fugitive' 				-- Git Fugitive
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }                                       -- A Vim plugin which shows a git diff in the sign column.
    -- use 'airblade/vim-gitgutter'         -- A Vim plugin which shows a git diff in the sign column.
    use 'TimUntersberger/neogit' 			-- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.

    -- General Plugins
    use 'windwp/nvim-autopairs' 			-- A minimalist autopairs for Neovim written by Lua
    use 'kevinhwang91/nvim-bqf'
    use 'kevinhwang91/rnvimr'
    use 'mhinz/vim-startify'
    use 'metakirby5/codi.vim'
    use 'moll/vim-bbye'
    use 'alvan/vim-closetag'
    use 'liuchengxu/vim-which-key'
    -- use 'liuchengxu/vista.vim'
    use 'majutsushi/tagbar'
    use 'terrortylor/nvim-comment'
    use 'bfredl/nvim-miniyank'
end)
