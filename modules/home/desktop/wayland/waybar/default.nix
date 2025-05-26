{
  flake.modules.homeManager.waybar =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      services = {
        blueman-applet.enable = true;
        network-manager-applet.enable = true;
      };

      programs.waybar = {
        enable = true;

        settings.main = {
          layer = "top";
          position = "bottom";
          height = 32;

          fixed-center = false;

          modules-center = [ "custom/spotify" ];
          modules-right = [
            "backlight"
            "pulseaudio"
            "memory"
            "cpu"
            "network"
            # "custom/vpn"
            "battery"
            "clock"
            "clock#date"
            "custom/notifs"

            "tray"
          ];
        } // (import ./_modules { inherit lib config pkgs; });
        style = builtins.readFile ./style.css;
      };
    };
}
