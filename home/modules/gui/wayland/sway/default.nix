{pkgs, ...}: {
  imports = [
    ./keybindings.nix
  ];

  wayland.windowManager.sway = {
    enable = true;

    config = {
      assigns = {
        "number 2" = [{app_id = "firefox";}];
        "number 4" = [{app_id = "thunderbird";}];
        "number 6" = [{app_id = "signal";}];
        "number 7" = [{class = "Zotero";}];
        "number 8" = [
          {app_id = "nheko";}
          {app_id = "Slack";}
          {app_id = "discord";}
          {app_id = "Jitsi Meet";}
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
        {class = "matplotlib";}
        {app_id = "python3";}
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

        # "type:pointer" = {
        #   accel_profile = "flat";
        #   pointer_accel = "0.3";
        # };

        "type:touchpad" = {
          tap = "enabled";
          # natural_scroll = "enabled";
        };
      };

      bars = [{command = "${pkgs.waybar}/bin/waybar";}];

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
              ${pkgs.killall}/bin/killall swaybg
              ${pkgs.swaybg}/bin/swaybg -m fill -i ${../wallpaper.png}
            '';
          in "${setWallpaper}";
          always = true;
        }
        {
          command = "${pkgs.kanshi}/bin/kanshi";
          always = true;
        }
        {command = "firefox";}
        {command = "thunderbird";}
        {command = "signal-desktop";}
        {command = "pidof btop || foot --title btop btop";}
        {command = "${pkgs.foot}/bin/foot";}
      ];
    };
  };
}
