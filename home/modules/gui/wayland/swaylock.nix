{
  programs.swaylock = {
    enable = true;

    settings = {
      daemonize = true;

      image = builtins.toString ./wallpaper.png;
      indicator-x-position = 100;
      indicator-y-position = 100;
    };
  };
}
