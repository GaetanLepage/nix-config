{ pkgs, ... }:

{
    imports = [
        ./autorandr.nix
        ./bspwm
        ./dunst.nix
        ./email.nix
        ./firefox.nix
        ./flameshot.nix
        ./gtk.nix
        ./keyboard.nix
        ./kitty.nix
        ./lockscreen
        ./picom.nix
        ./polybar
        ./rofi.nix
        ./sxhkd.nix
        ./zathura.nix
    ];

    home.packages = with pkgs; [
        arandr
        betterlockscreen
        mons
        xwallpaper
    ];

    xdg.dataFile.wallpaper = {
        source = ../wallpaper.jpg;
        target = "wallpaper.jpg";
    };

    services = {
        blueman-applet.enable = true;
        network-manager-applet.enable = true;
    };
}
