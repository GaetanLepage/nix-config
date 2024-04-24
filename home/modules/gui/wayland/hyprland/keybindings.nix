{
  pkgs,
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    # Enable workspace back and forth to work
    binds.allow_workspace_cycles = true;

    bind =
      [
        ##########
        # System #
        ##########
        # lock screen
        ", F8, exec, loginctl lock-session"

        ", XF86MonBrightnessUp, exec, ${lib.getExe pkgs.light} -A 10"
        ", XF86MonBrightnessDown, exec, ${lib.getExe pkgs.light} -U 10"

        "$mod, g, exec, ${lib.getExe pkgs.pavucontrol}"
      ]
      ++ (
        let
          unmute = "pactl set-sink-mute @DEFAULT_SINK@ off";
          volumePrefix = "pactl set-sink-volume @DEFAULT_SINK@";
          commandPrefix = "${unmute}; ${volumePrefix}";

          volumeDown = "${commandPrefix} -5%";
          volumeUp = "${commandPrefix} +5%";
        in [
          "$mod, down, exec, ${volumeDown}"
          ", XF86AudioLowerVolume, exec, ${volumeDown}"

          "$mod, up, exec, ${volumeUp}"
          ", XF86AudioRaiseVolume, exec, ${volumeUp}"

          ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ]
      )
      ++ [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl pause"
        ", XF86AudioNext, exec, playerctl next"
        "$mod, right, exec, playerctl next"
        ", XF86AudioNext, exec, playerctl previous"
        "$mod, left, exec, playerctl previous"

        # TODO
        # ", F9, exec, ${
        #
        # }"

        # Bluetooth
        "$mod, i, exec, ${pkgs.blueman}/bin/blueman-manager"
        "$mod SHIFT, i, exec, doas rfkill unblock bluetooth"
        "$mod CTRL, i, exec, doas rfkill block bluetooth"

        # Wireguard (VPN)
        "$mod, u, exec, doas systemctl start wg-quick-wg0"
        "$mod SHIFT, u, exec, doas systemctl stop wg-quick-wg0"

        # Dunst (notifications)
        "$mod, n, exec, ${pkgs.dunst}/bin/dunstctl set-paused false"
        "$mod SHIFT, n, exec, ${pkgs.dunst}/bin/dunstctl set-paused true"

        ################
        # Applications #
        ################
        # Terminal
        "$mod, RETURN, exec, foot"

        # Rofi
        "$mod, d, exec, ${lib.getExe config.programs.rofi.package} -show run"

        # Web browser
        "$mod, w, exec, firefox"

        # screenshot (flameshot)
        ", Print, exec, ${lib.getExe pkgs.flameshot} gui"

        "$mod, F3, exec, ${lib.getExe pkgs.xfce.thunar}"

        "$mod SHIFT, F7, exec, bg_stream lofi"
        "$mod, F7, exec, bg_stream stop"

        ######
        # WM #
        ######
        # quit/restart hyprland
        "$mod SHIFT, q, exit"
        "$mod SHIFT, r, exec, kanshictl reload"

        # kill window
        "$mod SHIFT, a, killactive,"

        # alternate between the tiled and monocle layout
        "$mod, z, fullscreen, 1"

        # Cycle through the windows of the current workspace
        "$mod, SPACE, cyclenext,"

        # Back and forth desktop
        "$mod, b, workspace, previous"

        # TODO
        # "$mod SHIFT, p, move workspace to output right"

        # STATE/FLAGS
        "$mod, f, fullscreen, 0"

        "$mod SHIFT, Space, togglefloating"

        # TODO
        # "$mod+v" = "layout toggle splitv splith";

        # FOCUS/SWAP

        # focus the node in the given direction
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        # focus the next/previous workspace
        "CTRL ALT, h, workspace, e-1"
        "CTRL ALT, l, workspace, e+1"

        "$mod, a, workspace, 1"
      ]
      ++ (
        lib.flatten (
          lib.mapAttrsToList
          (
            wsNumber: key: [
              "$mod, ${key}, workspace, ${wsNumber}"
              "$mod SHIFT, ${key}, movetoworkspace, ${wsNumber}"
            ]
          )
          {
            "1" = "ampersand";
            "2" = "eacute";
            "3" = "quotedbl";
            "4" = "apostrophe";
            "5" = "parenleft";
            "6" = "minus";
            "7" = "egrave";
            "8" = "underscore";
            "9" = "ccedilla";
            "10" = "agrave";
          }
        )
      );

    # Resize
    binde = [
      "$mod CTRL, h, resizeactive, -20 0"
      "$mod CTRL, j, resizeactive, 0 20"
      "$mod CTRL, k, resizeactive, 0 -20"
      "$mod CTRL, l, resizeactive, 20 0"
    ];
  };
}
