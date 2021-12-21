#!/bin/sh


pacman_install() {
    echo -e "\n[pacman] Installing $@"
    sudo pacman -S --noconfirm --needed $@
}

npm_install() {
    echo -e "\n[npm] Installing $@"
    sudo npm install -g $@
}

yarn_install() {
    echo -e "\n[yarn] Installing $@"
    sudo yarn global add $@
}

pip_install() {
    echo -e "\n[pip] Installing $@"
    pip install -U $@
}


# Install pip
pacman_install python-pip
# Update pip
pip_install pip

# Install node and neovim support
pacman_install nodejs npm
npm_install neovim

# Install pynvim
pip_install pynvim

# Install packer
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ -e $PACKER_PATH ]; then
    echo 'packer already installed'
else
    git clone https://github.com/wbthomason/packer.nvim $PACKER_PATH
fi

# Extra packages
pacman_install ripgrep fzf ranger

# neovim-remote
pip_install neovim-remote

# Tree-sitter
pacman_install tree-sitter

# Telescope
pacman_install fd
pacman_install ripgrep


###############
# LSP clients #
###############

# bash
npm_install bash-language-server

# C / C++
pacman_install clang

# LaTeX (texlab + xdotool for forward search in zathura)
pacman_install texlab xdotool

# Lua
pacman_install lua-language-server

# Python
pip_install python-lsp-server \
            pylint \
            flake8 \
            pyls-flake8 \
            mypy \
            pylsp-mypy

# JavaScript / TypeScript
npm_install typescript typescript-language-server
