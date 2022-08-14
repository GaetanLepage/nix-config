{
    type = "internal/backlight";

    card = "intel_backlight";

    label = " %percentage:3:%%";
    format = "<label> <bar>";

    bar = {
        width = 10;

        indicator   = { text = "|"; font = 1; };
        fill        = { text = "▐"; font = 2; foreground = "\${colors.green}"; };
        empty       = { text = "▐"; font = 2; foreground = "#40"; };
    };
}
