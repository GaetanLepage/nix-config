{pkgs, ...}: {
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
    in {
      laptop = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504";
            position = "0,0";
            scale = 1.3;
            status = "enable";
          }
        ];
        exec = mkWifiHook true;
      };

      inria = mkSingleExternalScreen {
        externalCriteria = "Dell Inc. DELL U2719DC 88QSTS2";
        mode = "2560x1440@59.95Hz";
        wifiState = true;
      };

      home = mkSingleExternalScreen {
        externalCriteria = "LG Electronics LG ULTRAGEAR 108MAHU2AU49";
        mode = "2560x1440@120Hz";
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
