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
    {
      text = "▁";
      foreground = green;
    }
    {
      text = "▂";
      foreground = green;
    }
    {
      text = "▃";
      foreground = green;
    }
    {
      text = "▄";
      foreground = green;
    }
    {
      text = "▅";
      foreground = yellow;
    }
    {
      text = "▆";
      foreground = yellow;
    }
    {
      text = "▇";
      foreground = yellow;
    }
    {
      text = "█";
      foreground = red;
    }
  ];
}
