-- ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
-- ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
-- ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
-- ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
-- ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
-- Website:  glepage.com
-- GitHub:   https://github.com/GaetanLepage
-- Email:    gaetan.lepage@inria.fr
--
-- #---------------#
-- | neovim config |
-- #---------------#

-- TODO
-- Telescope livegrep not working
-- statusline
-- disable auto chdir when opening a file from stratify
-- (write a custom function for keymappings)
-- pylint
-- highlight trailing white space
-- highlight 'TODO'

-- General mappings
require('utils')
require('plugins')
require('keymappings')
require('settings')
require('colorscheme')

-- Plugins
require('nv-barbar')
require('nv-colorizer')
require('nv-comment')
require('nv-compe')
-- require('nv-floaterm')
require('nv-fugitive')
require('nv-galaxyline')
-- require('nv-gitsigns')
-- require('nv-indentline')
require('nv-markdown-preview')
-- require('nv-neomake')
require('nv-nvim-autopairs')
require('nv-nvimtree')
require('nv-rnvimr')
require('nv-startify')
require('nv-simpylfold')
require('nv-tagbar')
require('nv-treesitter')
require('nv-telescope')
require('nv-vimtex')
-- require('nv-vista')
-- require('nv-floaterm')
-- require('nv-lspkind')

-- LSP
require('lsp')
require('lsp.bash-ls')
require('lsp.c-ls')
require('lsp.json-ls')
require('lsp.lua-ls')
require('lsp.python-ls')
require('lsp.vim-ls')
require('lsp.yaml-ls')
