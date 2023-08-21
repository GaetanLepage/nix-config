{
  pkgs,
  config,
  lib,
  ...
}: {
  wayland.windowManager.river.config.mappings = {
    keyboard.normal = let
      spawn = command: "spawn '${command}'";
    in
      ##########
      # System #
      ##########
      {
        "None F8" = let
          playerctl = "${pkgs.playerctl}/bin/playerctl";
          lock = pkgs.writeShellScript "lock" ''
            ${playerctl} pause
            ${playerctl} -p spotify pause
            ${pkgs.swaylock}/bin/swaylock
          '';
        in "spawn ${lock}";

        "None XF86MonBrightnessUp" = spawn "${pkgs.light}/bin/light -A 10";
        "None XF86MonBrightnessDown" = spawn "${pkgs.light}/bin/light -U 10";

        "Super g" = spawn "${pkgs.pavucontrol}/bin/pavucontrol";
      }
      // (
        let
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          unmute = "${pactl} set-sink-mute @DEFAULT_SINK@ off";
          volumePrefix = "${pactl} set-sink-volume @DEFAULT_SINK@";
          commandPrefix = "${unmute} && ${volumePrefix}";

          volumeDown = spawn "${commandPrefix} -5%";
          volumeUp = spawn "${commandPrefix} +5%";
        in {
          "Super Up" = volumeUp;
          "None XF86AudioRaiseVolume" = volumeUp;

          "Super Down" = volumeDown;
          "None XF86AudioLowerVolume" = volumeDown;

          "None XF86AudioMute" = spawn "${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
        }
      )
      // (
        let
          playerctl = "${pkgs.playerctl}/bin/playerctl";

          next = spawn "${playerctl} next";
          previous = spawn "${playerctl} previous";
        in {
          "None XF86AudioPlay" = spawn "${playerctl} play-pause";
          "None XF86AudioPause" = spawn "${playerctl} pause";
          "None XF86AudioNext" = next;
          "Super Right" = next;
          "None XF86AudioPrev" = previous;
          "Super Left" = previous;
        }
      )
      // {
        # Toggle touchpad
        # "None F9" = let
        #   showTouchpadState = pkgs.writeScript "show-touchpad-state" ''
        #     status=$(swaymsg -t get_inputs | ${pkgs.jq}/bin/jq --raw-output '.[] | select(.type=="touchpad") | .libinput.send_events')
        #     notify-send "Touchpad $status"
        #   '';
        # in "input type:touchpad events toggle enabled disabled; exec ${showTouchpadState}";

        # Bluetooth
        "None i" = spawn "${pkgs.blueman}/bin/blueman-manager";
        "Shift i" = spawn "doas rfkill unblock bluetooth";
        "Ctrl i" = spawn "doas rfkill block bluetooth";

        # Wireguard (VPN)
        "Super u" = spawn "doas systemctl start wg-quick-wg0";
        "Super+Shift u" = spawn "doas systemctl stop wg-quick-wg0";

        # Dunst (notifications)
        # "${mod}+n" = "exec ${pkgs.mako}/bin/makoctl set-mode silent";
        # "${mod}+Shift+n" = "exec ${pkgs.mako}/bin/makoctl set-mode default";
        "Super n" = spawn "${pkgs.dunst}/bin/dunstctl set-paused false";
        "Super+Shift n" = spawn "${pkgs.dunst}/bin/dunstctl set-paused true";
      }
      ################
      # Applications #
      ################
      // {
        # Terminal
        "Super Return" = spawn "${pkgs.foot}/bin/foot";

        # Rofi
        "Super d" = spawn "${config.programs.rofi.package}/bin/rofi -show run";

        # Web browser
        "Super w" = spawn "${pkgs.firefox}/bin/firefox";

        # screenshot (flameshot)
        # "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
        # TODO switch back to normal mapping (above) when issue is fixed
        "None Print" = spawn "${pkgs.flameshot}/bin/flameshot gui --raw | wl-copy";

        # file manager
        "Super F3" = spawn "${pkgs.xfce.thunar}/bin/thunar";
      }
      ########
      # River #
      ########
      // {
        # quit/restart bspwm
        "Super+Shift q" = "exit";
        # "Super+Shift r" = spawn "${config.home.homeDirectory}/${config.xdg.configFile."river/init".target}";

        # kill window
        "Super a" = "close";

        # alternate between the tiled and monocle layout
        "Super z" = "layout toggle splith tabbed";

        # Cycle through the nodes (leaves only) of the current desktop
        # "Super space" = "exec ${pkgs.i3-cycle-focus}/bin/i3-cycle-focus cycle";

        # Back and forth desktop
        "Super b" = "focus-previous-tag";

        # STATE/FLAGS

        "Super f" = "toggle-fullscreen";

        "Super+Shift space" = "toggle-float";

        # "${mod}+v" = "layout toggle splitv splith";

        # FOCUS/SWAP

        # Super+J and Super+K to focus the next/previous view in the layout stack
        "Super j" = "focus-view next";
        "Super k" = "focus-view previous";

        # Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
        # view in the layout stack
        "Super+Shift j" = "swap next";
        "Super+Shift k" = "swap previous";

        # focus the node in the given direction
        # "${mod}+h" = "focus left";
        # "${mod}+j" = "focus down";
        # "${mod}+k" = "focus up";
        # "${mod}+l" = "focus right";
        # "${mod}+Shift+h" = "move left";
        # "${mod}+Shift+j" = "move down";
        # "${mod}+Shift+k" = "move up";
        # "${mod}+Shift+l" = "move right";

        # focus the next/previous workspace
        # "Super+Ctrl h" = "workspace prev";
        # "Super+Ctrl l" = "workspace next";
        # "Ctrl+Alt h" = "workspace prev";
        # "Ctrl+Alt l" = "workspace next";

        # resize a window
        # "${mod}+r" = "mode resize";
      }
      // (
        lib.listToAttrs (
          lib.flatten (
            lib.mapAttrsToList
            (
              tag: key: let
                tags = "$((1 << $(${tag} - 1)))";
              in [
                {
                  name = "Super ${key}";
                  value = "set-focused-tags ${tags}";
                }
                {
                  name = "Super+Shift ${key}";
                  value = "set-view-tags ${tags}";
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

    # modes = {
    #   resize = {
    #     h = "resize shrink width 20 px";
    #     j = "resize grow height 20 px";
    #     k = "resize shrink height 20 px";
    #     l = "resize grow width 20 px";
    #     Escape = "mode default";
    #     Return = "mode default";
    #   };
    # };

    pointer.normal = {
      "Super BTN_LEFT" = "move-view";
      "Super BTN_RIGHT" = "resize-view";
    };
  };
}
