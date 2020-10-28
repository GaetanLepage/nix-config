#!/bin/sh
path=$(pwd)

# Home directory
ln -sf $path/.bash_profile $HOME/.bash_profile
ln -sf $path/.bashrc $HOME/.bashrc
ln -sf $path/.gitconfig $HOME/.gitconfig
ln -sf $path/.p10k.zsh $HOME/.p10k.zsh
ln -sf $path/.profile $HOME/.profile
ln -sf $path/.pylintrc $HOME/.pylintrc
ln -sf $path/.xinitrc $HOME/.xinitrc
ln -sf $path/.xprofile $HOME/.xprofile
ln -sf $path/.zprofile $HOME/.zprofile
ln -sf $path/.zshenv $HOME/.zshenv
ln -sf $path/.zshrc $HOME/.zshrc

delete_if_exists () {
    [ -d $1 ] && rm -rf $1
}

####################
# Config directory #
####################
[ ! -d $HOME/.config ] && mkdir $HOME/.config

delete_if_exists $HOME/.config/dunst
ln -sf $path/config/dunst $HOME/.config/dunst

delete_if_exists $HOME/.config/flameshot
ln -sf $path/config/flameshot $HOME/.config/flameshot

delete_if_exists $HOME/.config/gtk-2.0
ln -sf $path/config/gtk-2.0 $HOME/.config/gtk-2.0

delete_if_exists $HOME/.config/gtk-3.0
ln -sf $path/config/gtk-3.0 $HOME/.config/gtk-3.0

delete_if_exists $HOME/.config/gtk-4.0
ln -sf $path/config/gtk-4.0 $HOME/.config/gtk-4.0

delete_if_exists $HOME/.config/i3
ln -sf $path/config/i3 $HOME/.config/i3

delete_if_exists $HOME/.config/kitty
ln -sf $path/config/kitty $HOME/.config/kitty

delete_if_exists $HOME/.config/jesseduffield
mkdir -p $HOME/.config/jesseduffield
ln -sf $path/config/lazygit $HOME/.config/jesseduffield/lazygit

delete_if_exists $HOME/.config/nvim
ln -sf $path/config/nvim $HOME/.config/nvim

delete_if_exists $HOME/.config/pcmanfm
ln -sf $path/config/pcmanfm $HOME/.config/pcmanfm

delete_if_exists $HOME/.config/picom
ln -sf $path/config/picom $HOME/.config/picom

delete_if_exists $HOME/.config/polybar
ln -sf $path/config/polybar $HOME/.config/polybar

delete_if_exists $HOME/.config/ranger
ln -sf $path/config/ranger $HOME/.config/ranger

delete_if_exists $HOME/.config/shellconfig
ln -sf $path/config/shellconfig $HOME/.config/shellconfig

delete_if_exists $HOME/.config/zathura
ln -sf $path/config/zathura/ $HOME/.config/zathura

ln -sf $path/config/mimeapps.list $HOME/.config/mimeapps.list
ln -sf $path/config/user-dirs.dirs $HOME/.config/user-dirs.dirs
ln -sf $path/config/wall.jpg $HOME/.config/wall.jpg
ln -sf $path/config/icon_arch.png $HOME/.config/icon_arch.png

###########
# Scripts #
###########

delete_if_exists $HOME/scripts
ln -sf $path/scripts $HOME/scripts

#######
# SSH #
#######
[ ! -d $HOME/.ssh ] && mkdir -p $HOME/.ssh
ln -sf $path/ssh/config $HOME/.ssh/config

###################
# Local directory #
###################

[ ! -d $HOME/.local ] && mkdir -p $HOME/.local/share
[ ! -d $HOME/.local/share ] && mkdir $HOME/.local/share

# Fonts
[ -d $HOME/.local/share/fonts ] && rm -r $HOME/.local/share/fonts
ln -sf $path/.local/share/fonts $HOME/.local/share/fonts
