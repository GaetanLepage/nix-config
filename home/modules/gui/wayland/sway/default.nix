{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./keybindings.nix
    ./swaylock.nix
    ./waybar.nix
  ];

  wayland.windowManager.sway = {
    enable = true;

    config = {
      assigns = {
        "number 2" = [{app_id = "firefox";}];
        "number 4" = [{app_id = "thunderbird";}];
        "number 6" = [{app_id = "signal";}];
        "number 7" = [{class = "Zotero";}]; # inria
        "number 8" = [
          {app_id = "nheko";}
          {app_id = "Slack";} # inria
          {app_id = "discord";}
          {app_id = "Jitsi Meet";} # inria
        ];
        "number 9" = [{app_id = "Spotify";}];
        "number 10" = [{title = "btop";}];
      };

      floating.criteria = [
        {app_id = ".blueman-manager-wrapped";}
        {app_id = "nm-openconnect-auth-dialog";}
        {app_id = "nm-connection-editor";}
        {app_id = "pavucontrol";}
        {app_id = "flameshot";}
        {
          app_id = "thunderbird";
          title = "Edit Event*";
        }
        # Matplotlib plots
        {class = "matplotlib";} # inria
        {app_id = "python3";} # inria
      ];

      fonts = {
        names = ["DejaVu Sans Mono"];
        size = 12.0;
      };

      input = {
        "type:keyboard" = {
          xkb_layout = "fr";
          xkb_options = "caps:swapescape";
          xkb_numlock = "enabled";

          repeat_delay = "300";
          repeat_rate = "50";
        };

        "type:touchpad" = {
          tap = "enabled";
        };
      };

      bars = [{command = lib.getExe config.programs.waybar.package;}];

      colors = let
        background = "#282828";
        red = "#cc241d";
        purple = "#b16286";
        darkgray = "#1d2021";
        lightgray = "#ebdbb2";
      in {
        focused = {
          border = lightgray;
          background = lightgray;
          text = background;
          indicator = purple;
          childBorder = lightgray;
        };
        focusedInactive = {
          border = darkgray;
          background = darkgray;
          text = lightgray;
          indicator = purple;
          childBorder = darkgray;
        };
        unfocused = {
          border = darkgray;
          background = darkgray;
          text = lightgray;
          indicator = purple;
          childBorder = darkgray;
        };
        urgent = {
          border = red;
          background = red;
          text = lightgray;
          indicator = red;
          childBorder = red;
        };
      };

      defaultWorkspace = "workspace number 1";

      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
      };

      startup = [
        {command = "systemctl --user import-environment";}
        {
          command = let
            setWallpaper = pkgs.writeShellScript "set-wallpaper" ''
              ${lib.getExe pkgs.killall} swaybg
              ${lib.getExe pkgs.swaybg} -m fill -i ${../wallpaper.png}
            '';
          in "${setWallpaper}";
          always = true;
        }
        {
          command = lib.getExe pkgs.kanshi;
          always = true;
        }
        {command = "firefox";}
        {command = "thunderbird";}
        {command = lib.getExe pkgs.foot;}
        {command = "doas ${lib.getExe' pkgs.g810-led "g610-led"} -a ff";}
      ];
    };
  };
}
