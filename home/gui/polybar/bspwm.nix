{
    type = "internal/bspwm";

    # scrolling through populated workspaces is handled at the bar level
    enable-scroll = false;

    format = {
        text = "<label-state>";
        padding = 0;
    };

    label = let

        defaults = {
            text = "%name%";
            padding = 4;
            font = 3;
            # Disable underline by making it transparent
            underline = "#00";

            background = "$\{colors.background}";
        };

    in builtins.mapAttrs (name: value: defaults // value) {
        focused     = { background = "#4e4e4e"; };
        occupied    = { };
        urgent      = { background = "#821717"; };
        empty       = { foreground = "#4e4e4e"; };

        # Separator in between workspaces
        separator   = { text = " "; padding = 0; };
    };
}
