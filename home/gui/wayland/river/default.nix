{pkgs, ...}: {
  imports = [
    ./keybindings.nix
  ];

  wayland.windowManager.river = {
    enable = true;

    xwayland = true;
    # extraSessionVariables = {
    #   FOO = "foo";
    #   BAR = "bar";
    #   FOURTY_TWO = 42;
    # };

    systemdIntegration = true;

    config = {
      rules = {

    #     floating.criteria = [
    #       {app_id = ".blueman-manager-wrapped";}
    #       {app_id = "nm-openconnect-auth-dialog";}
    #       {app_id = "nm-connection-editor";}
    #       {app_id = "pavucontrol";}
    #       {app_id = "flameshot";}
    #       {
    #         app_id = "thunderbird";
    #         title = "Edit Event*";
    #       }
    #     ];
        float = [
          {app_id = "mpd";}
          {title = "popup title with spaces";}
        ];
      };
      mappings = {
        keyboard = {
          normal = {
            "Alt E" = "toggle-fullscreen";
            "Alt T" = "toggle-float";
            "Alt P" = "enter-mode passthrough";
            "Alt Q" = "close";
            "Alt Return" = "spawn foot";
          };
          passthrough."Alt P" = "enter-mode normal";
          locked = {
            "None XF86AudioRaiseVolume" = "spawn 'pamixer -i 5'";
            "None XF86AudioLowerVolume" = "spawn 'pamixer -d 5'";
          };
        };
        pointer = {
          normal = {
            "Super BTN_LEFT" = "move-view";
            "Super BTN_RIGHT" = "resize-view";
            "Super BTN_MIDDLE" = "toggle-float";
            "Alt BTN_LEFT" = "move-view";
          };
        };
      };
      attachMode = "bottom";
      backgroundColor = "0x002b36";
      border = {
        color = {
          focused = "93a1a1";
          unfocused = "586e75";
          urgent = "ff0000";
        };
        width = 2;
      };
      focusFollowsCursor = "normal";
      hideCursor = {
        timeout = 2;
        whenTyping = true;
      };
      cursorWarp = "on-output-change";
      repeatRate = "50 300";
      xCursorTheme = {
        name = "name";
        size = 12;
      };
      keyboard = {
        layout = {
          name = "fr";
          options = "caps:escape";
        };
      };
      inputs = {


    #     input = {
    #       "type:keyboard" = {
    #         xkb_layout = "fr";
    #         xkb_options = "caps:swapescape";
    #         xkb_numlock = "enabled";
    #
    #         repeat_delay = "300";
    #         repeat_rate = "50";
    #       };
    #
    #       # "type:pointer" = {
    #       #   accel_profile = "flat";
    #       #   pointer_accel = "0.3";
    #       # };
    #
    #       "type:touchpad" = {
    #         tap = "enabled";
    #         # natural_scroll = "enabled";
    #       };
    #     };

        pointer-foo-bar = {
          events = "enabled";
          accelProfile = "flat";
          pointerAccel = -0.3;
          tap = false;
        };
      };
      layoutGenerator = {
        name = "rivertile";
        arguments = "-view-padding 6 -outer-padding 8";
      };
    };
    startupPrograms = [
      "firefox" "foot"
    ];

    # extraConfig = ''
    #   some
    #   extra config
    # '';

    #   config = {
    #     assigns = {
    #       "number 2" = [{app_id = "firefox";}];
    #       "number 4" = [{app_id = "thunderbird";}];
    #       "number 6" = [{class = "Signal";}];
    #       "number 7" = [{class = "Zotero";}];
    #       "number 8" = [
    #         {class = "Element";}
    #         {class = "Slack";}
    #         {class = "discord";}
    #         {class = "Jitsi Meet";}
    #       ];
    #       "number 9" = [{class = "Spotify";}];
    #       "number 10" = [{title = "btop";}];
    #     };
    #
    #
    #
    #     bars = [{command = "${pkgs.waybar}/bin/waybar";}];
    #
    #     colors = let
    #       background = "#282828";
    #       red = "#cc241d";
    #       purple = "#b16286";
    #       darkgray = "#1d2021";
    #       lightgray = "#bdae93";
    #     in {
    #       focused = {
    #         border = lightgray;
    #         background = lightgray;
    #         text = background;
    #         indicator = purple;
    #         childBorder = lightgray;
    #       };
    #       focusedInactive = {
    #         border = darkgray;
    #         background = darkgray;
    #         text = lightgray;
    #         indicator = purple;
    #         childBorder = darkgray;
    #       };
    #       unfocused = {
    #         border = darkgray;
    #         background = darkgray;
    #         text = lightgray;
    #         indicator = purple;
    #         childBorder = darkgray;
    #       };
    #       urgent = {
    #         border = red;
    #         background = red;
    #         text = lightgray;
    #         indicator = red;
    #         childBorder = red;
    #       };
    #     };
    #
    #     defaultWorkspace = "workspace number 1";
    #
    #     window = {
    #       hideEdgeBorders = "smart";
    #       titlebar = false;
    #     };
    #
    #     startup = [
    #       {command = "systemctl --user import-environment";}
    #       {
    #         command = let
    #           setWallpaper = pkgs.writeShellScript "set-wallpaper" ''
    #             ${pkgs.killall}/bin/killall swaybg
    #             ${pkgs.swaybg}/bin/swaybg -m fill -i ${../wallpaper.png}
    #           '';
    #         in "${setWallpaper}";
    #         always = true;
    #       }
    #       {
    #         command = "${pkgs.kanshi}/bin/kanshi";
    #         always = true;
    #       }
    #       {command = "firefox";}
    #       {command = "thunderbird";}
    #       {command = "signal-desktop";}
    #       {command = "pidof btop || foot --title btop btop";}
    #       {command = "${pkgs.foot}/bin/foot";}
    #     ];
    #   };
  };
}
