{
  programs.waybar = {
    settings.main = {
      modules-left = ["sway/workspaces"];

      "sway/workspaces" = {
        persistent-workspaces = {
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

    style = ''
      #workspaces button {
        padding: 0 8px;
        border: 1px solid #4e4e4e;
        margin: 0 4px 0 0;
        background: #0a0a0a;
        color: #ffffff;
      }

      #workspaces button.focused {
        color: #0a0a0a;
        background: #ffffff;
      }
      #workspaces button.urgent {
        background: #fb4934;
      }
      /* Empty */
      #workspaces button.persistent {
        color: #4e4e4e;
      }
    '';
  };
}
