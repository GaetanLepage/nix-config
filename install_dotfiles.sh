#!/bin/sh
# ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
# ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
# ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
# ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
# ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
# website:  glepage.com
# github:   https://github.com/gaetanlepage
# email:    gaetan.lepage@inria.fr
#
# #-----------------------------#
# | dotfile installation script |
# #-----------------------------#

path=$(pwd)

link_config_file () {
    SOURCE_FILE=$1
    SOURCE_PATH=$path/$SOURCE_FILE
    DEST_PATH=$HOME/$SOURCE_FILE

    ln -sf $SOURCE_PATH $DEST_PATH

    echo "Linked config file \"$SOURCE_FILE\" ($SOURCE_PATH -> $DEST_PATH)"
}

delete_if_exists () {
    [ -d $1 ] && rm -rf $1 && echo "Removed existing directory $1"
}


create_if_not_exist () {
    [ ! -d $1 ] && mkdir -p $1 "Created directory $1 (it did not exist before)"
}

config_dir_link () {
    LINK_PATH="$HOME/.config/$1"
    delete_if_exists $LINK_PATH
    ln -sf $path/config/$1 $LINK_PATH
    echo "Linked config directory for $1 ($LINK_PATH)"
}


# Home directory
echo -e "\n## Linking \"home\" dotfiles ##"
link_config_file .bash_profile
link_config_file .bashrc
link_config_file .gitconfig
link_config_file .gtkrc-2.0
link_config_file .p10k.zsh
link_config_file .profile
link_config_file .pylintrc
link_config_file .xinitrc
link_config_file .xprofile
link_config_file .Xresources
link_config_file .zprofile
link_config_file .zshenv
link_config_file .zshrc

####################
# Config directory #
####################
[ ! -d $HOME/.config ] && mkdir $HOME/.config && echo -e "\nCreated config file ($HOME/.config/)"

echo -e "\n## Linking conventional dotfiles ##"
config_dir_link bspwm
config_dir_link dunst
config_dir_link flameshot
config_dir_link gtk-3.0
config_dir_link gtk-4.0
config_dir_link i3
config_dir_link kitty
config_dir_link nvim
config_dir_link pcmanfm
config_dir_link picom
config_dir_link polybar
config_dir_link ranger
config_dir_link rofi
config_dir_link shellconfig
config_dir_link sxhkd
config_dir_link zathura

delete_if_exists $HOME/.config/jesseduffield
mkdir -p $HOME/.config/jesseduffield
ln -sf $path/config/lazygit $HOME/.config/jesseduffield/lazygit

ln -sf $path/config/mimeapps.list $HOME/.config/mimeapps.list
ln -sf $path/config/user-dirs.dirs $HOME/.config/user-dirs.dirs
ln -sf $path/config/wall.jpg $HOME/.config/wall.jpg
ln -sf $path/config/wall.png $HOME/.config/wall.png
ln -sf $path/config/icon_arch.png $HOME/.config/icon_arch.png

################
# Local folder #
################
create_if_not_exist $HOME/.local/share
create_if_not_exist $HOME/.local/share/gnupg

###########
# Scripts #
###########

delete_if_exists $HOME/scripts
ln -sf $path/scripts $HOME/scripts

#######
# SSH #
#######
create_if_not_exist $HOME/.ssh
ln -sf $path/ssh/config $HOME/.ssh/config

#########
# Fonts #
#########
delete_if_exists $HOME/.fonts
ln -sf $path/.fonts $HOME/.fonts
