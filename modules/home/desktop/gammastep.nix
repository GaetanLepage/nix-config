{
  flake.modules.homeManager.gammastep = {
    services.gammastep = {
      enable = true;

      latitude = 45.5;
      longitude = 5.0;
    };
  };
}
