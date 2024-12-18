{
  lib,
  config,
  pkgs,
  ...
}: {
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
    F6 = let
      obs-do = lib.getExe (pkgs.obs-do.overrideAttrs (old: rec {
        src = pkgs.fetchFromGitHub {
          owner = "GaetanLepage";
          repo = "obs-do";
          rev = "81a1f85a48e23c3f4b31a418c889ace38ea51b35";
          hash = "sha256-fe4kWF+d6dtwTP7IuOu0OiesSNx+UYXJ8xgqCZcimoM=";
        };
        cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
          inherit src;
          outputHash = "sha256-+hlPv7KjNX6QmwAsjMAeGwFUgKrr96IWkbyayHqkHKM=";
        });
      }));
      toggle-script = pkgs.writeShellScript "mute-obs" ''
        if ${obs-do} toggle-mute; then
          if ${obs-do} get-mute | grep true; then
            notify-send "Microphone muted"
          else
            notify-send "Microphone un-muted"
          fi
        fi
      '';
    in "exec ${toggle-script}";
  };
}
