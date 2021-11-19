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



#########################
# OPTIONS AND VARIABLES ###########################################################################
#########################
path=$(pwd)

while getopts ":a:r:b:p:h" o; do case "${o}" in
	h) printf "Optional arguments for custom use:\\n  -r: Dotfiles repository (local file or url)\\n  -p: Dependencies and programs csv (local file or url)\\n  -a: AUR helper (must have pacman-like syntax)\\n  -h: Show this message\\n" && exit ;;
	r) dotfilesrepo=${OPTARG} && git ls-remote "$dotfilesrepo" || exit ;;
	b) repobranch=${OPTARG} ;;
	p) progsfile=${OPTARG} ;;
	a) aurhelper=${OPTARG} ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit ;;
esac done

[ -z "$dotfilesrepo" ] && dotfilesrepo="https://github.com/GaetanLepage/dotfiles.git"
[ -z "$progsfile" ] && progsfile="https://raw.githubusercontent.com/GaetanLepage/LARBS/master/progs.csv"
[ -z "$aurhelper" ] && aurhelper="yay"
[ -z "$repobranch" ] && repobranch="master"


############
# SOFTWARE ########################################################################################
############
if type xbps-install >/dev/null 2>&1; then
	installpkg(){ xbps-install -y "$1" >/dev/null 2>&1 ;}
	grepseq="\"^[PGV]*,\""
elif type apt >/dev/null 2>&1; then
	installpkg(){ apt-get install -y "$1" >/dev/null 2>&1 ;}
	grepseq="\"^[PGU]*,\""
else
    distro="arch"
    installpkg(){ pacman --noconfirm --needed -S "$1" >/dev/null 2>&1 ;}
	grepseq="\"^[PGA]*,\""
fi

install_software () {
    echo TODO
}


#########
# SHELL ###########################################################################################
#########
install_shell () {
    echo TODO
}


############
# DOTFILES ########################################################################################
############

link_config_file () {
    SOURCE_FILE=$1
    SOURCE_PATH=$path/$SOURCE_FILE
    DEST_PATH=$HOME/${2:-$SOURCE_FILE}

    ln -sf $SOURCE_PATH $DEST_PATH

    echo "Linked config file \"$(basename $SOURCE_FILE)\" ($SOURCE_PATH -> $DEST_PATH)"
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


install_dotfiles() {
    # Home directory
    echo -e "\n## Linking \"home\" dotfiles ##"
    link_config_file .gitconfig
    link_config_file .p10k.zsh
    link_config_file .condarc
    link_config_file x11/
    ln -sf $HOME/.config/x11/xinitrc $HOME/.xinitrc
    ln -sf $HOME/.config/x11/Xmodmap $HOME/.Xmodmap
    ln -sf $HOME/.config/x11/xprofile $HOME/.xprofile
    ln -sf $HOME/.config/shell/profile $HOME/.profile
    ln -sf $HOME/.config/shell/bashrc $HOME/.bashrc
    ln -sf $HOME/.config/shell/zshenv $HOME/.zshenv
    link_config_file config/tmux/tmux.conf .tmux.conf
    link_config_file config/vpn_ensimag.ovpn .config/


    ####################
    # Config directory #
    ####################
    [ ! -d $HOME/.config ] && mkdir $HOME/.config && echo -e "\nCreated config file ($HOME/.config/)"

    echo -e "\n## Linking conventional dotfiles ##"
    config_dir_link autorandr
    config_dir_link betterlockscreen
    config_dir_link bpytop
    config_dir_link btop
    config_dir_link bspwm
    config_dir_link dunst
    config_dir_link gtk-2.0
    config_dir_link gtk-3.0
    config_dir_link gtk-4.0
    config_dir_link i3
    config_dir_link kitty
    config_dir_link nvim
    config_dir_link paru
    config_dir_link picom
    config_dir_link python
    config_dir_link polybar
    config_dir_link ranger
    config_dir_link rofi
    config_dir_link shell
    config_dir_link sxhkd
    config_dir_link tmux
    config_dir_link zathura
    config_dir_link x11

    delete_if_exists $HOME/.config/jesseduffield
    mkdir -p $HOME/.config/jesseduffield
    ln -sf $path/config/lazygit $HOME/.config/jesseduffield/lazygit

    link_config_file config/betterlockscreenrc .config/betterlockscreenrc
    link_config_file config/mimeapps.list .config/mimeapps.list
    link_config_file config/user-dirs.dirs .config/user-dirs.dirs
    link_config_file config/wall.jpg .config/wall.jpg
    link_config_file config/icon_arch.png .config/icon_arch.png

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
}


#######
# VPN #############################################################################################
#######
install_vpn () {
    # VPN ensimag
    VPN_ENSIMAG='vpn_ensimag'
    if ! nmcli c show $VPN_ENSIMAG > /dev/null 2>&1; then
        echo "$VPN_ENSIMAG does not exist: creating it."
        nmcli c import type openvpn file $HOME/.config/vpn_ensimag.ovpn
        nmcli c modify $VPN_ENSIMAG ipv4.never-default true
        nmcli c modify $VPN_ENSIMAG vpn.user-name lepageg
    fi
}


########
# Main ############################################################################################
########

install_software
install_shell
install_dotfiles
install_vpn
