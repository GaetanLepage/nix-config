{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    package = pkgs.waybar.overrideAttrs (_: {
      patches = [
        # Fixes sway workspaces (https://github.com/Alexays/Waybar/issues/3009)
        (pkgs.fetchpatch {
          url = "https://github.com/Alexays/Waybar/commit/2ffd9a94a505a2e7e933ea8303f9cf2af33c35fe.patch";
          hash = "sha256-u87t6zzslk1mzSfi4HQ6zDPFr7qMfsvymTy3HBxVTJQ=";
        })
      ];
    });

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
