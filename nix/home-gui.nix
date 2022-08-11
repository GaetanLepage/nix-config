# ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
# ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
# ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
# ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
# ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
# website:  glepage.com
# github:   https://github.com/gaetanlepage
# email:    gaetan.lepage@inria.fr
#
# #--------------------------------------------#
# | Home-manager configuration for GUI systems |
# #--------------------------------------------#

{ config, pkgs, ... }:

{
    imports = [
        # CLI (general)
        ./home.nix

        # GUI specific
        ./home-gui
    ];

    home = {
        packages = with pkgs; [
            betterlockscreen
            xwallpaper
        ];
    };

    xdg.dataFile.wallpaper = {
        source = ../wallpaper.jpg;
        target = "wallpaper.jpg";
    };

    services = {
        blueman-applet.enable = true;
        network-manager-applet.enable = true;

        nextcloud-client = {
            enable = true;
            startInBackground = true;
        };
    };
}
