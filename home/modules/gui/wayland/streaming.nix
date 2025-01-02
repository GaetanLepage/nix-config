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
        obs-do = lib.getExe (
          pkgs.obs-do.overrideAttrs (old: rec {
            version = "0.1.6";
            src = pkgs.fetchFromGitHub {
              owner = "jonhoo";
              repo = "obs-do";
              tag = "v0.1.6";
              hash = "sha256-t6m/PX4GMCFH9wFrOaU/dcrbKitUXQlOcU7aUyJPpxA=";
            };
            cargoDeps = old.cargoDeps.overrideAttrs (
              lib.const {
                inherit src;
                outputHash = "sha256-ggxNVgtSAU8tr4mPUvhXIqq02v47y+arMUbk0zlc5yY=";
              }
            );
          })
        );
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
