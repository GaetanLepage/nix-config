{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.kanshi
  ];

  services.kanshi = {
    enable = true;

    settings = let
      laptopScreenName = "eDP-1";
      disabledLaptopScreen = {
        criteria = laptopScreenName;
        status = "disable";
      };

      mkWifiHook = on: "${pkgs.networkmanager}/bin/nmcli radio wifi ${
        if on
        then "on"
        else "off"
      }";

      home = let
        homeScreenName = "LG Electronics LG ULTRAGEAR 108MAHU2AU49";
      in [
        {
          # Home screen config
          output = {
            criteria = homeScreenName;
            mode = "2560x1440@143.932999Hz";
            position = "0,0";
          };
        }

        # home
        {
          profile = {
            name = "home";
            outputs = [
              disabledLaptopScreen
              {criteria = homeScreenName;}
            ];
            exec = mkWifiHook false;
          };
        }

        # stream
        {
          profile = {
            name = "stream";
            outputs = [
              {criteria = homeScreenName;}
              {
                criteria = laptopScreenName;
                position = "2560,0";
              }
            ];
            exec = mkWifiHook false;
          };
        }
      ];
    in
      [
        # Laptop screen (default configuration)
        {
          output = {
            criteria = laptopScreenName;
            mode = "2256x1504";
            position = "0,0";
            scale = 1.333333;
            status = "enable";
          };
        }

        ## PROFILES ##

        # laptop
        {
          profile = {
            name = "laptop";
            outputs = [{criteria = laptopScreenName;}];
            exec = mkWifiHook true;
          };
        }

        # inria
        {
          profile = {
            name = "inria";
            outputs = [
              disabledLaptopScreen
              {
                criteria = "Dell Inc. DELL U2719DC 88QSTS2";
                position = "0,0";
                mode = "2560x1440@59.95Hz";
              }
            ];
            exec = mkWifiHook false;
          };
        }
      ]
      ++ home;
  };
}
