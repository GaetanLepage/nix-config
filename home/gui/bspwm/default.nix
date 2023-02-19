{config, ...}: let
  extra_rules_script_path = "bspwm/extra_rules.sh";
in {
  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      "primary" = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
    };

    rules = {
      # States
      Blueman-manager.state = "floating";
      ".blueman-manager-wrapped".state = "floating";
      Nm-connection-editor.state = "floating";
      Pavucontrol.state = "floating";
      "Thunderbird:Calendar:*".state = "floating";
      "Steam:Steam:'Steam - News*'".state = "floating";
      Zathura.state = "tiled";

      # Assignments
      firefox.desktop = "2";
      thunderbird.desktop = "4";
      Signal.desktop = "6";
      Zotero.desktop = "7";
      Element.desktop = "8";
      Steam.desktop = "8";
      Slack.desktop = "8";
      discord.desktop = "8";
      "Jitsi Meet".desktop = "8";
      btop.desktop = "10";
    };

    settings = {
      border_width = 2;
      window_gap = 0;

      top_padding = 0;
      bottom_padding = 30;
      left_padding = 0;
      right_padding = 0;

      single_monocle = true;
      borderless_monocle = true;
      gapless_monocle = true;
      focus_follows_pointer = true;
      pointer_follows_focus = false;

      merge_overlapping_monitors = true;
      remove_disabled_monitors = true;
      remove_unplugged_monitors = true;

      ignore_ewmh_focus = true;

      pointer_modifier = "mod4";
      pointer_action1 = "move";
      pointer_action2 = "resize_side";
      pointer_action3 = "resize_corner";

      ##########
      # Colors #
      ##########
      normal_border_color = "#282828";
      active_border_color = "#282828";
      focused_border_color = "#ebdbb2";
      presel_feedback_color = "#ebdbb2";
      urgent_border_color = "#cc241d";
    };

    extraConfig = ''

      # Add custom rules for Spotify and zotero
      bspc config external_rules_command ${config.xdg.configHome}/${extra_rules_script_path}

      # Automatically set certain worskpaces' layout
      bspc desktop 2 -l monocle
      bspc desktop 4 -l monocle
      bspc desktop 7 -l monocle
      bspc desktop 8 -l monocle

      # Automatically laod the first autorandr profile
      autorandr --change --ignore-lid
    '';

    startupPrograms = [
      "xwallpaper --zoom ${config.xdg.dataFile.wallpaper.target}"

      # GUI apps
      "pidof kitty || ( bspc desktop -f 1 && kitty )"
      "pidof firefox || firefox"
      "thunderbird"
      "signal-desktop"
      "pidof btop || kitty --class btop btop"

      # Keyboard
      "sudo g610-led -a ff"
      # Increase key speed via a rate change
      "xset r rate 300 50"

      # polybar
      "killall polybar; polybar bar -r"
    ];
  };

  xdg.configFile.bspwm_extra_rules = {
    executable = true;
    target = extra_rules_script_path;
    source = ./extra_rules.sh;
  };
}
