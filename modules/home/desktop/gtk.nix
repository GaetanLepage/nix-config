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

      # Prevents GTK from saving "recently accessed files"
      xdg.dataFile."recently-used.xbel" = {
        force = true;
        text = "";
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

        # New default behavior since 26.05:
        # -> The default value of `gtk.gtk4.theme` has changed from `config.gtk.theme` to `null`
        gtk4.theme = null;

        gtk3.bookmarks = [
          "file://${config.xdg.userDirs.download}"
          "file://${config.home.homeDirectory}/temp"
          "file:///mnt"
          "file:///mnt/server"
          "file:///mnt/server/gaetan/photos/1_grimpe"
        ];

        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      };
    };
}
