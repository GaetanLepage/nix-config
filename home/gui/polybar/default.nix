{pkgs, ...}: {
  services.polybar = {
    enable = true;

    settings = {
      settings = {
        screenchange-reload = true;

        # Define fallback values used by all module formats
        format = {
          underline = "#ffffff";
          padding = 1;
        };
      };

      colors = {
        green = "#b8bb26";
        yellow = "#fabd2f";
        red = "#fb4934";

        background = "#0a0a0a";
      };

      #######
      # Bar #
      #######
      "bar/bar" = import ./bar.nix;

      ###########
      # Modules #
      ###########
      # Left
      "module/bspwm" = import ./bspwm.nix;

      # Center
      "module/spotify" = import ./spotify.nix pkgs;

      # Right
      "module/brightness" = import ./brightness.nix;
      "module/sound" = import ./sound.nix;
      "module/ram" = import ./ram.nix;
      "module/cpu" = import ./cpu.nix;
      "module/wifi" = import ./wifi.nix;
      "module/battery" = import ./battery.nix;
      "module/time" = import ./time.nix;
      "module/date" = import ./date.nix;
      "module/vpn" = import ./vpn.nix pkgs;
      "module/dunst" = import ./dunst.nix pkgs;
    };

    script = "";
  };
}
