{
  services.mako = {
    enable = true;

    # Colors
    backgroundColor = "#282828";
    borderColor = "#ebdbb2";
    textColor = "#ffffff";

    font = "DejaVu Sans 16";

    # The maximum height and width of a single notification
    height = 300;
    width = 800;

    # format = "%s %p\\n%b";
    padding = "10";

    defaultTimeout = 2000; #ms

    extraConfig = ''
      [mode=default]

      [mode=silent]
      invisible=1
    '';
  };
}
