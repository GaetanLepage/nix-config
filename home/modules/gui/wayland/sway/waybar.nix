{
  programs.waybar = {
    settings.main = {
      modules-left = ["sway/workspaces"];

      "sway/workspaces" = {
        persistent_workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
          "7" = [];
          "8" = [];
          "9" = [];
          "10" = [];
        };

        enable-bar-scroll = true;
        disable-scroll-wraparound = true;
      };
    };
  };
}
