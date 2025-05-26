{ pkgs, ... }:
{
  imports = [
    ./wayland

    ./bg-stream.nix
    ./firefox.nix
    ./nheko.nix
  ];

  home.packages = with pkgs; [
    libnotify

    ## GUI applications
    inkscape # inria
    drawio # inria

    # IM
    discord
    signal-desktop
    slack # inria

    # Office / productivity
    libreoffice-fresh
    kdePackages.okular # inria ? (also delete keyboard shortcuts file)
    zotero # inria

    # Misc
    spotify
  ];
}
