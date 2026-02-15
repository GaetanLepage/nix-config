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
        wifi = true;
        screens = {
          laptop.status = "disable";
          lg_27.status = "enable";
        };
      };
    };
  };
}
