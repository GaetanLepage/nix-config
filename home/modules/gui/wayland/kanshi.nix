{pkgs, ...}: {
  home.packages = [
    pkgs.kanshi
  ];

  services.kanshi = {
    enable = true;

    profiles = let
      mkWifiHook = on: "${pkgs.networkmanager}/bin/nmcli radio wifi ${
        if on
        then "on"
        else "off"
      }";

      mkSingleExternalScreen = {
        externalCriteria ? "DP-1",
        mode,
        wifiState ? true,
      }: {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = externalCriteria;
            inherit mode;
            position = "0,0";
          }
        ];
        exec = mkWifiHook wifiState;
      };

      laptopOutput = {
        criteria = "eDP-1";
        mode = "2256x1504";
        position = "0,0";
        scale = 1.333333;
        status = "enable";
      };

      homeScreen = {
        criteria = "LG Electronics LG ULTRAGEAR 108MAHU2AU49";
        mode = "2560x1440@143.932999Hz";
      };
    in {
      laptop = {
        outputs = [laptopOutput];
        exec = mkWifiHook true;
      };

      stream = {
        outputs = [
          (homeScreen // {position = "0,0";})
          (laptopOutput // {position = "2560,0";})
        ];
        exec = mkWifiHook false;
      };

      inria = mkSingleExternalScreen {
        externalCriteria = "Dell Inc. DELL U2719DC 88QSTS2";
        mode = "2560x1440@59.95Hz";
        wifiState = true;
      };

      home = mkSingleExternalScreen {
        externalCriteria = homeScreen.criteria;
        inherit (homeScreen) mode;
        wifiState = false;
      };

      dom = mkSingleExternalScreen {
        externalCriteria = "BNQ BenQ GW2460 N9D04183SL0";
        mode = "1920x1080";
        wifiState = true;
      };
    };
  };
}
