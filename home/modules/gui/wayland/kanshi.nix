{
  lib,
  pkgs,
  ...
}: {
  services.kanshi = {
    enable = true;

    settings = let
      laptopScreenName = "eDP-1";
      disabledLaptopScreen = {
        criteria = laptopScreenName;
        status = "disable";
      };
      laptopScreen = {
        criteria = laptopScreenName;
        mode = "2256x1504";
        position = "0,0";
        scale = 1.333333;
        status = "enable";
      };

      mkWifiHook = on: "${lib.getExe' pkgs.networkmanager "nmcli"} radio wifi ${
        if on
        then "on"
        else "off"
      }";

      home = let
        homeScreenName = "LG Electronics LG ULTRAGEAR 108MAHU2AU49";
        homeScreen = {
          criteria = homeScreenName;
          mode = "2560x1440@143.932999Hz";
          position = "0,0";
        };
      in [
        # home
        {
          profile = {
            name = "home";
            outputs = [
              disabledLaptopScreen
              homeScreen
            ];
            exec = mkWifiHook false;
          };
        }

        # stream
        {
          profile = {
            name = "stream";
            outputs = [
              (laptopScreen // {position = "0,310";})
              (homeScreen // {position = "1694,0";})
            ];
            exec = mkWifiHook false;
          };
        }
      ];
    in
      [
        # laptop
        {
          profile = {
            name = "laptop";
            outputs = [laptopScreen];
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
            exec = mkWifiHook true;
          };
        }
      ]
      ++ home;
  };
}
