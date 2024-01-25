{
  pkgs,
  config,
  ...
}: let
  cursor = {
    name = "Numix-Cursor-Light";
    package = pkgs.numix-cursor-theme;
  };
in {
  home.pointerCursor = cursor;

  gtk = {
    enable = true;

    font.name = "DejaVu Sans 12";

    theme = {
      name = "Matcha-dark-aliz";
      package = pkgs.matcha-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = cursor;

    gtk3.bookmarks = [
      "file://${config.xdg.userDirs.download}"
      "file://${config.home.homeDirectory}/temp"
      "file:///mnt"
      "file:///mnt/server"

      "file://${config.home.homeDirectory}/inria/communication/repo/reading_group"
      "file://${config.home.homeDirectory}/inria/communication/repo/meetings"
    ];

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
}
