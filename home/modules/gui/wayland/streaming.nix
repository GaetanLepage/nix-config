{
  lib,
  config,
  pkgs,
  ...
}:
{
  services = {
    kanshi._profiles.stream = {
      inherit (config.services.kanshi._profiles.home) wifi;
      screens = {
        laptop = {
          status = "enable";
          position = "0,310";
        };
        home = {
          status = "enable";
          position = "1694,0";
        };
      };
    };
  };

  wayland.windowManager.sway.config.keybindings = {
    F6 =
      let
        obs-do = lib.getExe pkgs.obs-do;

        toggle-script = pkgs.writeShellScript "mute-obs" ''
          if ${obs-do} toggle-mute; then
            if ${obs-do} get-mute | grep true; then
              notify-send "Microphone muted"
            else
              notify-send "Microphone un-muted"
            fi
          fi
        '';
      in
      "exec ${toggle-script}";
  };
}
