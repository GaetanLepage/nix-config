let
    text = "%name%";
    padding = 4;
    font = 3;
    # Disable underline by making it transparent
    underline = "#00";

in {
    type = "internal/bspwm";

    # scrolling through populated workspaces is handled at the bar level
    enable-scroll = false;

    format = {
        text = "<label-state>";
        padding = 0;
    };

    label = {
        focused     = { inherit text; inherit font; inherit padding; inherit underline; background = "#4e4e4e"; };
        occupied    = { inherit text; inherit font; inherit padding; inherit underline; };
        urgent      = { inherit text; inherit font; inherit padding; inherit underline; background = "#821717"; };
        empty       = { inherit text; inherit font; inherit padding; inherit underline; foreground = "#4e4e4e"; };

        # Separator in between workspaces
        separator   = { text = " "; padding = 0; inherit font; };
    };
}
