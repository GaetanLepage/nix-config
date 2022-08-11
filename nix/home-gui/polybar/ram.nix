{
    type = "internal/memory";

    card = "intel_backlight";

    label = {
        text = " %percentage_used%%";
        font = 1;
    };

    format = "<label> <bar-used>";

    bar.used =
        let
            green = "\${colors.green}";
            yellow = "\${colors.yellow}";
            red = "\${colors.red}";

        in {
            width = 10;

            foreground = [ green green yellow red ];

            indicator = { text = "|"; font = 1; foreground = "#ff"; };
            fill =      { text = "▐"; font = 2; };
            empty =     { text = "▐"; font = 2; foreground = "#55"; };
        };
}
