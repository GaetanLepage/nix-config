{
  services.sxhkd = {
    enable = true;

    keybindings = let
      all_num_keys = "ampersand,eacute,quotedbl,apostrophe,parenleft,minus,egrave,underscore,ccedilla,agrave";
    in {
      ##########
      # System #
      ##########

      # Reload script
      "super + r" = "reload";

      # make sxhkd reload its configuration files:
      "super + @Escape" = "pkill -USR1 -x sxhkd";

      # Lock
      "{F8,XF86PowerOff}" = "lock";

      # Screen brightness
      "XF86MonBrightnessUp" = "doas xbacklight -inc 10";
      "XF86MonBrightnessDown" = "doas xbacklight -dec 10";

      # Mons
      "super + c" = "xrandr --output eDP-1 --mode 1920x1200 --primary && mons -o && reload";

      # Audio
      "super + g" = "pavucontrol";

      # Volume control
      "{XF86AudioRaiseVolume,super + Up}" = "pactl set-sink-mute @DEFAULT_SINK@ off && pactl set-sink-volume @DEFAULT_SINK@ +5%";

      "{XF86AudioLowerVolume,super + Down}" = "pactl set-sink-mute @DEFAULT_SINK@ off && pactl set-sink-volume @DEFAULT_SINK@ -5%";

      "XF86AudioMute" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";

      # Media player
      "XF86AudioPlay" = "playerctl play-pause";
      "XF86AudioPause" = "playerctl pause";
      "{XF86AudioNext,super + Right}" = "playerctl next";
      "{XF86AudioPrev,super + Left}" = "playerctl previous";

      # Toggle touchpad
      "XF86TouchpadToggle" = "touchpad_toggle";

      # Bluetooth
      "super + i" = "blueman-manager";
      "super + shift + i" = "doas rfkill unblock bluetooth";
      "super + ctrl + i" = "doas rfkill block bluetooth";

      # Wireguard (VPN)
      "super + u" = "doas systemctl start wg-quick-wg0";
      "super + shift + u" = "doas systemctl stop wg-quick-wg0";

      # Dunst (notifications)
      "super + n" = "dunstctl set-paused false";
      "super + shift + n" = "dunstctl set-paused true";

      ################
      # Applications #
      ################

      # Terminal
      "super + Return" = "kitty";

      # Rofi
      "super + d" = "rofi -show run";

      # Web browser
      "super + w" = "firefox";

      # xkill
      "super + x" = "xkill";

      # picom
      "super + p" = "systemctl --user start picom && dunstify 'started picom'";
      "super + shift + p" = "systemctl --user stop picom && dunstify 'stopped picom'";

      # screenshot (flameshot)
      "Print" = "flameshot gui";

      # pcmanfm
      "super + F3" = "pcmanfm";

      #########
      # BSPWM #
      #########

      # quit/restart bspwm
      "super + shift + {q,r}" = "bspc {quit,wm -r}";

      # kill window
      "super + a" = "bspc node -c";

      # alternate between the tiled and monocle layout
      "super + z" = "bspc desktop -l next";

      # Cycle through the nodes (leaves only) of the current desktop
      "super + space" = "bspc node -f next.local.leaf";

      # Back and forth desktop
      "super + b" = "bspc desktop -f last";

      # Send window to desktop and swap to desktop
      "super + control + {${all_num_keys}}" = "bspc node -d {1-9,10} && bspc desktop -f {1-9,10}";

      # focus or send to the given desktop
      "super + {_,shift + }{${all_num_keys}}" = "bspc {desktop -f,node -d} {1-9,10}";

      # Send desktop to monitor and swap to desktop
      "super + s" = "bspc desktop -m last --follow && bspwm_reorder_desktops";

      # STATE/FLAGS

      # set the window state
      "super + t" = "bspc node -t tiled";

      "super + f" = "bspc node -t \\~fullscreen";

      "super + m" = "bspc desktop -l monocle";

      "super + ctrl + space" = "bsp-layout cycle";

      "super + shift + space" = "bspc node -t \\~floating";

      "super + v" = "bspc node @/ -R 90";

      # set the node flags
      "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";

      # FOCUS/SWAP

      # focus the node in the given direction
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";

      # send the node in the given direction
      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}.local";

      # focus the next/previous desktop in the current monitor
      "ctrl + alt + {h,l}" = "bspc desktop -f {prev,next}.occupied";

      # MOVE/RESIZE

      # resize a window
      "super + ctrl + h" = "bspc node -z left    -20 0   || bspc node -z right   -20 0";
      "super + ctrl + j" = "bspc node -z bottom  0   20  || bspc node -z top     0   20";
      "super + ctrl + k" = "bspc node -z top     0   -20 || bspc node -z bottom  0   -20";
      "super + ctrl + l" = "bspc node -z right   20  0   || bspc node -z left    20  0";
    };
  };
}
