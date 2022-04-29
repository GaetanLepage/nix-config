# Neovim configuration

This is my neovim configuration.\
It is entirely written in lua.

**Neovim version:** latest (currently `0.8.0-dev`)

The entry point of the configuration is the
[`init.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/init.lua)
file.

## Configuration structure

### [`lua/`](https://github.com/GaetanLepage/dotfiles/tree/master/config/nvim/lua) General configuration

- [`colorscheme.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/colorscheme.lua):
    Colorscheme and custom highlights
- [`keymappings.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/keymappings.lua):
    General keymappings (plugin independent)
- [`settings.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/settings.lua):
    General settings (vim options and custom autocommands)
- [`utils.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/utils.lua):
    Utility functions used in the configuration


### [`lua/lsp/`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/lsp) LSP (language server protocole)

I use the native integrated LSP client from Neovim.

Some general LSP-related configuration is done in
[`lua/lsp/init.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/lsp/init.lua)

This directory is organized so that **1 language = 1 file in
[`lua/lsp/`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/lsp)**.\
Hence, the LSP configuration for `python` can be found in
[`lua/lsp/python.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/lsp/python.lua).


### [`lua/plugins/`](https://github.com/GaetanLepage/dotfiles/tree/master/config/nvim/lua/plugins) Plugins

**Plugin manager:** [`packer.nvim`](https://github.com/wbthomason/packer.nvim)\
The plugins are declared in the
[`packer.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/plugins/packer.lua)
file.

This directory is organized so that **1 plugin = 1 file in
[`lua/plugins/`](https://github.com/GaetanLepage/dotfiles/tree/master/config/nvim/lua/plugins)**.\
Hence, the plugin `xyz` is configured in the file `lua/plugins/xyz.lua`.\
All those files are sourced by
[`lua/plugins/init.lua`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/lua/plugins/init.lua).


## Bootstrapping script

Back when I was using Arch Linux, I used the
[`install_nvim_dependencies.sh`](https://github.com/GaetanLepage/dotfiles/blob/master/config/nvim/install_nvim_dependencies.sh)
bash script to install/update all the dependencies for this configuration (plugin dependencies,
language servers...).

I am currently using [NixOS](https://nixos.org/) and do not need this script anymore.
