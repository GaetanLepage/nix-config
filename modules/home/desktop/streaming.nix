{
  flake.modules.homeManager.streaming =
    { lib, pkgs, ... }:
    {
      home.shellAliases = {
        vs = "vim /tmp/stream.txt";
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
    };
}
