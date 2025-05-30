{
  flake.modules.homeManager.kanshi = {
    services.kanshi = {
      enable = true;

      screens = {
        home = {
          criteria = "LG Electronics LG ULTRAGEAR 108MAHU2AU49";
          mode = "2560x1440@143.932999Hz";
          position = "0,0";
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
    };
  };
}
