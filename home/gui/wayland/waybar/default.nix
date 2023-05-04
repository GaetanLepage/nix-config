{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    # systemd.enable = true;

    settings = [
      (
        {
          layer = "top";
          position = "bottom";
          height = 32;

          fixed-center = false;

          modules-left = ["sway/workspaces"];
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
        // (import ./modules pkgs)
      )
    ];
    style = builtins.readFile ./style.css;
  };
}