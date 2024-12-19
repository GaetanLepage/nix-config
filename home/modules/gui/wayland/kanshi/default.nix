{
  imports = [
    ./module.nix
  ];

  services.kanshi = {
    enable = true;

    screens = {
      laptop = {
        criteria = "eDP-1";
        mode = "2256x1504";
        position = "0,0";
        scale = 1.333333;
      };
      home = {
        criteria = "LG Electronics LG ULTRAGEAR 108MAHU2AU49";
        mode = "2560x1440@143.932999Hz";
        position = "0,0";
      };
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
    };
  };
}
