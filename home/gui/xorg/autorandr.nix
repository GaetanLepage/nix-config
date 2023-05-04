{
  # Autostart autorandr at login
  services.autorandr = {
    enable = true;
    ignoreLid = true;
  };

  programs.autorandr = {
    enable = true;

    profiles = let
      eDP-1-edid = "00ffffffffffff0009e5610900000000011e0104a51e137803da25a7544b9925105054000000010101010101010101010101010101019c3e80c870b03c40302036002ebc1000001abc2980c870b03c40302036002dbc10000000000000fe00424f452043510a202020202020000000fe004e4531343057554d2d4e36330a0073";

      mkWifiHook = on: "nmcli radio wifi ${
        if on
        then "on"
        else "off"
      }";

      mkSingleExternalScreen = {
        externalName ? "DP-1",
        externalEdid,
        mode ? "2560x1440",
        rate ? "60.00",
        wifiState ? true,
      }: {
        fingerprint = {
          eDP-1 = eDP-1-edid;
          ${externalName} = externalEdid;
        };
        config = {
          eDP-1.enable = false;
          ${externalName} = {
            crtc = 0;
            primary = true;
            position = "0x0";
            inherit mode;
            inherit rate;
          };
        };
        hooks.postswitch = ''
          ${mkWifiHook wifiState}
          systemctl --user start picom
        '';
      };
    in {
      laptop = {
        fingerprint.eDP-1 = eDP-1-edid;
        config = {
          eDP-1 = {
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
            rate = "60.00";
          };
        };
        hooks.postswitch = ''
          ${mkWifiHook true}
          systemctl --user stop picom
        '';
      };

      inria = mkSingleExternalScreen {
        externalName = "DP-1";
        externalEdid = "00ffffffffffff0010ac9c4157354d43341d0104a53c22783eee95a3544c99260f5054a54b00714f8180a940d1c00101010101010101565e00a0a0a029503020350055502100001a000000ff00383851535453320a2020202020000000fc0044454c4c20553237313944430a000000fd00384c1e5a19010a20202020202001fb02031cf14f90050403020716010611121513141f23097f0783010000023a801871382d40582c450055502100001e7e3900a080381f4030203a0055502100001a011d007251d01e206e28550055502100001ebf1600a08038134030203a0055502100001a00000000000000000000000000000000000000000000000000000012";
        rate = "59.95";
        wifiState = true;
      };

      home = mkSingleExternalScreen {
        externalName = "HDMI-1";
        externalEdid = "00ffffffffffff001e6dd25b11170400081f010380462778ea8cb5af4f43ab260e5054210800d1c06140010101010101010101010101e9e800a0a0a0535030203500b9882100001a000000fd003c901ee63c000a202020202020000000fc004c4720554c545241474541520a000000ff003130384d41485532415534390a01b102034cf1230907074d100403011f13123f5d5e5f60616d030c001000b83c20006001020367d85dc401788003e30f00186d1a000002053c900004614f614fe2006ae305c000e606050161614f6fc200a0a0a0555030203500b9882100001a565e00a0a0a0295030203500b9882100001a000000000000000000000000000000db";
        rate = "120.00";
        wifiState = false;
      };

      dom = mkSingleExternalScreen {
        externalName = "HDMI-1";
        externalEdid = "00ffffffffffff0009d1c578455400002617010380351e782e6b35a455559f270c5054a56b80d1c081c081008180a9c0b30001010101023a801871382d40582c4500132b2100001e000000ff004e39443034313833534c300a20000000fd00324c1e5311000a202020202020000000fc0042656e51204757323436300a200163020322f14f90050403020111121314060715161f2309070765030c00100083010000023a801871382d40582c4500132b2100001f011d8018711c1620582c2500132b2100009f011d007251d01e206e285500132b2100001e8c0ad08a20e02d10103e9600132b21000018000000000000000000000000000000000000000000e7";
        mode = "1920x1080";
        wifiState = true;
      };
    };
  };
}