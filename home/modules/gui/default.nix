{pkgs, ...}: {
  imports = [
    ./wayland

    ./bg-stream.nix
    ./dunst.nix
    ./email.nix
    ./firefox.nix
    ./flameshot.nix
    ./gtk.nix
    ./nheko.nix
    ./rofi.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    libnotify

    ## GUI applications

    # IM
    discord
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
    udiskie = {
      enable = true;
      tray = "never";
    };
  };
}
