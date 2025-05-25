{
  flake.modules.homeManager.host_framework =
    { config, ... }:
    {
      services.kanshi = {
        screens.laptop = {
          criteria = "eDP-1";
          mode = "2256x1504";
          position = "0,0";
          scale = 1.333333;
        };

        _profiles = {
          laptop = {
            screens.laptop.status = "enable";
            wifi = true;
          };
          home = {
            wifi = false;
            screens = {
              laptop.status = "disable";
              home.status = "enable";
            };
          };
          studio = {
            wifi = false;
            screens = {
              laptop.status = "disable";
              hp.status = "enable";
            };
          };
          stream = {
            inherit (config.services.kanshi._profiles.home) wifi;
            screens = {
              laptop = {
                status = "enable";
                # position = "0,310";
                position = "0,0";
              };
              hp = {
                status = "enable";
                position = "1694,0";
              };
            };
          };
        };
      };
    };
}
