{ pkgs, ... }:

{
    imports = [
        ./autorandr.nix
        ./betterlockscreen.nix
        ./bspwm
        ./dunst.nix
        ./firefox.nix
        ./flameshot.nix
        ./gtk.nix
        ./keyboard.nix
        ./kitty.nix
        ./picom.nix
        ./polybar
        ./rofi.nix
        ./sxhkd.nix
        ./zathura.nix
    ];

    home.packages = with pkgs; [
        betterlockscreen
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
