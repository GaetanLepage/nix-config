let
    green = "\${colors.green}";
    yellow = "\${colors.yellow}";
    red = "\${colors.red}";

in {
    type = "internal/cpu";

    interval = 0.5;

    label = " %percentage:02%%";
    format = "<label> <ramp-coreload>";

    ramp-coreload = [
        { text = "▁"; font = 2; foreground = green;   }
        { text = "▂"; font = 2; foreground = green;   }
        { text = "▃"; font = 2; foreground = green;   }
        { text = "▄"; font = 2; foreground = green;   }
        { text = "▅"; font = 2; foreground = yellow;  }
        { text = "▆"; font = 2; foreground = yellow;  }
        { text = "▇"; font = 2; foreground = yellow;  }
        { text = "█"; font = 2; foreground = red;     }
    ];
}

