{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings.main =
      {
        layer = "top";
        position = "bottom";
        height = 32;

        fixed-center = false;

        modules-center = ["custom/spotify"];
        modules-right = [
          "backlight"
          "pulseaudio"
          "memory"
          "cpu"
          "network"
          "custom/vpn"
          "battery"
          "clock"
          "clock#date"
          "custom/notifs"

          "tray"
        ];
      }
      // (import ./modules pkgs);
    style = builtins.readFile ./style.css;
  };
}
