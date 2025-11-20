{
  flake.modules.homeManager.sway = {
    wayland.windowManager.sway = {
      config = {
        defaultWorkspace = "workspace number 1";

        assigns = {
          "number 2" = [ { app_id = "firefox"; } ];
          "number 4" = [ { app_id = "thunderbird"; } ];
          "number 6" = [ { app_id = "signal"; } ];
          "number 8" = [
            { app_id = "nheko"; }
            { app_id = "discord"; }
          ];
          "number 9" = [ { app_id = "spotify"; } ];
          "number 10" = [ { title = "btop"; } ];
        };
      };
    };
  };
}
