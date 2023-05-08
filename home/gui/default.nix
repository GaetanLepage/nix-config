{pkgs, ...}: {
  imports = [
    ./wayland

    ./dunst.nix
    ./email.nix
    ./firefox.nix
    ./flameshot.nix
    ./gtk.nix
    ./rofi.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    libnotify

    ## GUI applications

    # IM
    discord
    element-desktop
    jitsi-meet-electron
    signal-desktop
    slack

    # Office / productivity
    libreoffice-fresh
    okular
    zotero

    # Misc
    spotify
  ];

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
