{
    type = "internal/battery";

    battery = "BAT0";
    adapter = "AC0";

    full-at = 98;

    format = {
        charging    = "<ramp-capacity> <label-charging> ﮣ";
        discharging = "<ramp-capacity> <label-discharging>";
        full        = "<ramp-capacity> <label-full> ﮣ";
    };

    ramp.capacity = [ " " " " " " " " " " ];
}
