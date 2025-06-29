{
  flake.modules.homeManager.gtk =
    {
      pkgs,
      config,
      ...
    }:
    let
      cursorTheme = {
        name = "Numix-Cursor-Light";
        package = pkgs.numix-cursor-theme;
      };
    in
    {
      home.pointerCursor = {
        enable = true;
        inherit (cursorTheme)
          name
          package
          ;
      };

      gtk = {
        enable = true;

        font = {
          name = "DejaVu Sans";
          size = 12;
        };

        theme = {
          name = "Matcha-dark-aliz";
          package = pkgs.matcha-gtk-theme;
        };

        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };

        inherit cursorTheme;

        gtk3.bookmarks = [
          "file://${config.xdg.userDirs.download}"
          "file://${config.home.homeDirectory}/temp"
          "file:///mnt"
          "file:///mnt/server"

          # inria
          "file://${config.home.homeDirectory}/inria/code/rlan/output/plots"
          "file://${config.home.homeDirectory}/inria/communication/manuscript/figures"
          "file://${config.home.homeDirectory}/inria/communication/defense/slides"
        ];

        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      };
    };
}
