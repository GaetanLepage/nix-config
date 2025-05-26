{
  flake.modules.homeManager.udiskie = {
    services.udiskie = {
      enable = true;
      tray = "never";
    };
  };
}
