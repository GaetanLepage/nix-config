{
  programs.waybar = {
    settings.main = {
      modules-left = ["hyprland/workspaces"];

      "hyprland/workspaces" = {
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

        on-scroll-up = "hyprctl dispatch workspace e-1";
        on-scroll-down = "hyprctl dispatch workspace e+1";
      };
    };

    style = ''
      #workspaces button {
        padding: 0 8px;
        border: 1px solid #4e4e4e;
        margin: 0 4px 0 0;
        background: #0a0a0a;
        color: #ffffff;
      }

      #workspaces button.active {
        color: #0a0a0a;
        background: #ffffff;
      }
      #workspaces button.urgent {
        background: #fb4934;
      }
      /* Empty */
      #workspaces button.empty {
        color: #4e4e4e;
      }
    '';
  };
}
