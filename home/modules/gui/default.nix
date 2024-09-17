{pkgs, ...}: {
  imports = [
    ./wayland

    ./bg-stream.nix
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
    inkscape
    drawio

    # IM
    discord
    nheko
    jitsi-meet-electron
    signal-desktop
    slack # inria

    # Office / productivity
    libreoffice-fresh
    okular
    zotero # inria

    # Misc
    spotify
  ];

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
    udiskie = {
      enable = true;
      tray = "never";
    };
  };
}
