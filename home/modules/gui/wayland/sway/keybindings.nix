{
  pkgs,
  config,
  lib,
  ...
}: {
  wayland.windowManager.sway.config = let
    mod = "Mod4";

    inherit (lib) getExe;
    playerctl = getExe pkgs.playerctl;
  in {
    modifier = mod;

    keybindings =
      ##########
      # System #
      ##########
      {
        F8 = "exec ${
          pkgs.writeShellScript "lock" ''
            ${playerctl} pause
            ${playerctl} -p spotify pause
            ${getExe config.programs.swaylock.package}
          ''
        }";

        XF86MonBrightnessUp = "exec ${getExe pkgs.light} -A 10";
        XF86MonBrightnessDown = "exec ${getExe pkgs.light} -U 10";

        "${mod}+g" = "exec ${getExe pkgs.pavucontrol}";
      }
      // (
        let
          pactl = "exec ${pkgs.pulseaudio}/bin/pactl";
          unmute = "${pactl} set-sink-mute @DEFAULT_SINK@ off";
          volumePrefix = "${pactl} set-sink-volume @DEFAULT_SINK@";
          commandPrefix = "${unmute}; ${volumePrefix}";

          volumeDown = "${commandPrefix} -5%";
          volumeUp = "${commandPrefix} +5%";
        in {
          "${mod}+Up" = volumeUp;
          XF86AudioRaiseVolume = volumeUp;

          "${mod}+Down" = volumeDown;
          XF86AudioLowerVolume = volumeDown;

          XF86AudioMute = "${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
        }
      )
      // (
        let
          next = "exec ${playerctl} next";
          previous = "exec ${playerctl} previous";
        in {
          XF86AudioPlay = "exec ${playerctl} play-pause";
          XF86AudioPause = "exec ${playerctl} pause";
          XF86AudioNext = next;
          "${mod}+Right" = next;
          XF86AudioPrev = previous;
          "${mod}+Left" = previous;
        }
      )
      // {
        # Toggle touchpad
        "Shift+F9" = let
          showTouchpadState = pkgs.writeShellScript "show-touchpad-state" ''
            status=$(swaymsg -t get_inputs | ${pkgs.jq}/bin/jq --raw-output '.[] | select(.type=="touchpad") | .libinput.send_events')
            notify-send "Touchpad $status"
          '';
        in "input type:touchpad events toggle enabled disabled; exec ${showTouchpadState}";

        # Bluetooth
        "${mod}+i" = "exec ${pkgs.blueman}/bin/blueman-manager";
        "${mod}+Shift+i" = "exec doas rfkill unblock bluetooth";
        "${mod}+Ctrl+i" = "exec doas rfkill block bluetooth";

        # Wireguard (VPN)
        "${mod}+u" = "exec doas systemctl start wg-quick-wg0";
        "${mod}+Shift+u" = "exec doas systemctl stop wg-quick-wg0";

        # Dunst (notifications)
        "${mod}+n" = "exec ${pkgs.dunst}/bin/dunstctl set-paused false";
        "${mod}+Shift+n" = "exec ${pkgs.dunst}/bin/dunstctl set-paused true";
      }
      ################
      # Applications #
      ################
      // {
        # Terminal
        "${mod}+Return" = "exec ${getExe pkgs.foot}";

        # Rofi
        "${mod}+d" = "exec ${getExe config.programs.rofi.package} -show run";

        # Web browser
        "${mod}+w" = "exec ${getExe pkgs.firefox}";

        # screenshot (flameshot)
        # "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
        # TODO switch back to normal mapping (above) when issue is fixed
        "Print" = "exec ${getExe pkgs.flameshot} gui --raw | wl-copy";

        # file manager
        "${mod}+F3" = "exec ${getExe pkgs.xfce.thunar}";

        "${mod}+Shift+F7" = "exec bg_stream lofi";
        "${mod}+F7" = "exec bg_stream stop";
      }
      ########
      # Sway #
      ########
      // {
        # quit/restart sway
        "${mod}+Shift+q" = "exec ${pkgs.sway}/bin/swaymsg exit";
        "${mod}+Shift+r" = "reload";

        # kill window
        "${mod}+Shift+a" = "kill";

        # alternate between the tiled and monocle layout
        "${mod}+z" = "layout toggle splith tabbed";

        # Cycle through the nodes (leaves only) of the current desktop
        "${mod}+space" = "exec ${pkgs.i3-cycle-focus}/bin/i3-cycle-focus cycle";

        # Back and forth desktop
        "${mod}+b" = "workspace back_and_forth";

        "${mod}+Shift+p" = "move workspace to output right";

        # STATE/FLAGS

        "${mod}+f" = "fullscreen toggle";

        "${mod}+Shift+space" = "floating toggle";

        "${mod}+v" = "layout toggle splitv splith";

        # FOCUS/SWAP

        # focus the node in the given direction
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # focus the next/previous workspace
        "${mod}+ctrl+h" = "workspace prev";
        "${mod}+ctrl+l" = "workspace next";
        "ctrl+Alt+h" = "workspace prev";
        "ctrl+Alt+l" = "workspace next";

        # resize a window
        "${mod}+r" = "mode resize";

        "${mod}+a" = "workspace number 1";
      }
      // (
        lib.listToAttrs (
          lib.flatten (
            lib.mapAttrsToList
            (
              wsNumber: key: [
                {
                  name = "${mod}+${key}";
                  value = "workspace number ${wsNumber}";
                }
                {
                  name = "${mod}+Shift+${key}";
                  value = "move container to workspace number ${wsNumber}";
                }
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
        )
      );

    modes = {
      resize = {
        h = "resize shrink width 20 px";
        j = "resize grow height 20 px";
        k = "resize shrink height 20 px";
        l = "resize grow width 20 px";
        Escape = "mode default";
        Return = "mode default";
      };
    };
  };
}
