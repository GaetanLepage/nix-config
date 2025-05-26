{
  flake.modules.homeManager.sway = {
    wayland.windowManager.sway = {
      config = {
        defaultWorkspace = "workspace number 1";

        assigns = {
          "number 2" = [ { app_id = "firefox"; } ];
          "number 4" = [ { app_id = "thunderbird"; } ];
          "number 6" = [ { app_id = "signal"; } ];
          "number 7" = [ { app_id = "Zotero"; } ]; # inria
          "number 8" = [
            { app_id = "nheko"; }
            { app_id = "Slack"; } # inria
            { app_id = "discord"; }
            { app_id = "Jitsi Meet"; } # inria
          ];
          "number 9" = [ { app_id = "spotify"; } ];
          "number 10" = [ { title = "btop"; } ];
        };
      };
    };
  };
}
