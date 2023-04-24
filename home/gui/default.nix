{pkgs, ...}: {
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
    ./lockscreen.nix
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

    # Helpers
    xclip

    # GUI applications
    discord
    element-desktop
    jitsi-meet-electron
    libreoffice-fresh
    okular
    pcmanfm
    signal-desktop
    slack
    spotify
    thunderbird
    zathura
    zotero
  ];

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
