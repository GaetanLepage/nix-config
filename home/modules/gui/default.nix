{ pkgs, ... }:
{
  imports = [
    ./wayland

    ./bg-stream.nix
    ./dunst.nix
    ./email.nix
    ./firefox.nix
    ./flameshot.nix
    ./gtk.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    libnotify

    ## GUI applications
    inkscape # inria
    drawio # inria

    # IM
    discord
    nheko
    signal-desktop
    slack # inria

    # Office / productivity
    libreoffice-fresh
    okular # inria ? (also delete keyboard shortcuts file)
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
