{ pkgs, ... }:

{
    home.pointerCursor = {
        name = "Numix-Cursor-Light";
        package = pkgs.numix-cursor-theme;
    };

    gtk = {
        enable = true;

        font.name = "DejaVu Sans 11";

        theme = {
            name = "Matcha-dark-aliz";
            package = pkgs.matcha-gtk-theme;
        };

        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
    };
}
