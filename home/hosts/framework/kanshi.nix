{ config, ... }:
{
  services.kanshi = {
    screens = {
      laptop = {
        criteria = "eDP-1";
        mode = "2256x1504";
        position = "0,0";
        scale = 1.333333;
      };
      # inria
      inria = {
        criteria = "Dell Inc. DELL U2719DC 88QSTS2";
        position = "0,0";
        mode = "2560x1440@59.95Hz";
      };
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
      inria = {
        screens = {
          laptop.status = "disable";
          inria.status = "enable";
        };
        wifi = true;
      };
      stream = {
        inherit (config.services.kanshi._profiles.home) wifi;
        screens = {
          laptop = {
            status = "enable";
            position = "0,310";
          };
          home = {
            status = "enable";
            position = "1694,0";
          };
        };
      };
    };
  };
}
