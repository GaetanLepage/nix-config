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
      benq = {
        criteria = "BNQ BenQ GW2460 N9D04183SL0";
        position = "0,0";
        mode = "1920x1080@60.000Hz";
      };
      hp = {
        criteria = "Hewlett Packard HP LA2405x CN43510531";
        position = "0,0";
        mode = "1920x1200@59.950Hz";
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
}
