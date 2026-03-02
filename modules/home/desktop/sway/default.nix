{
  flake.modules.homeManager.sway =
    {
      config,
      lib,
      osConfig,
      pkgs,
      ...
    }:
    {
      wayland.windowManager.sway = {
        enable = true;
        xwayland = osConfig.programs.sway.xwayland.enable;

        config = {
          floating.criteria = [
            { app_id = ".blueman-manager-wrapped"; }
            { app_id = "nm-openconnect-auth-dialog"; }
            { app_id = "nm-connection-editor"; }
            { app_id = "pavucontrol"; }
            { app_id = "flameshot"; }
            {
              app_id = "thunderbird";
              title = "Edit Event*";
            }
            # Matplotlib plots
            { class = "matplotlib"; }
            { app_id = "python3"; }
            { app_id = "xdg-desktop-portal-gtk"; } # file picker
          ];

          bars = [ { command = lib.getExe config.programs.waybar.package; } ];
        };
      };
    };
}
