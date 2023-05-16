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

      attachMode = "bottom";

      backgroundColor = "#282828";
      border = {
        color = {
          focused = "#ebdbb2";
          unfocused = "#282828";
          urgent = "#cc241d";
        };
        width = 2;
      };

      focusFollowsCursor = "normal";

      hideCursor = {
        timeout = 2;
        whenTyping = true;
      };
      repeatRate = "50 300";
      # xCursorTheme = {
      #   name = "name";
      #   size = 12;
      # };
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

        # pointer-foo-bar = {
        #   events = "enabled";
        #   accelProfile = "flat";
        #   pointerAccel = -0.3;
        #   tap = false;
        # };
      };
      layoutGenerator = {
        name = "rivertile";
        # arguments = "-view-padding 6 -outer-padding 8";
      };
    };
    startupPrograms = [
      "firefox"
      "foot"
      "kanshi"

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

      #       {command = "signal-desktop";}
      #       {command = "pidof btop || foot --title btop btop";}
      #       {command = "${pkgs.foot}/bin/foot";}
    ];

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
    #
    #     defaultWorkspace = "workspace number 1";
    #
    #     window = {
    #       hideEdgeBorders = "smart";
    #       titlebar = false;
    #     };
  };
}
