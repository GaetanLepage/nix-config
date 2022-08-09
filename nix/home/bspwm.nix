{ ... }:

{
    xsession.windowManager.bspwm = {

        enable = true;

        monitors = {
            "primary" = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
        };

        rules = {
            # States
            Blueman-manager.state               = "floating";
            ".blueman-manager-wrapped".state    = "floating";
            Nm-connection-editor.state          = "floating";
            Pavucontrol.state                   = "floating";
            "Thunderbird:Calendar:*".state      = "floating";
            "Steam:Steam:'Steam - News*'".state = "floating";       # TODO test
            Zathura.state                       = "tiled";

            # Assignments
            Firefox.desktop         = "2";
            Thunderbird.desktop     = "4";
            Signal.desktop          = "6";
            Element.desktop         = "8";
            Steam.desktop           = "8";
            Slack.desktop           = "8";
            discord.desktop         = "8";
            "Jitsi Meet".desktop    = "8";
            btop.desktop            = "8";
        };


        settings = {

            border_width                = 2;
            window_gap                  = 0;

            top_padding                 = 0;
            bottom_padding              = 30;
            left_padding                = 0;
            right_padding               = 0;

            single_monocle              = true;
            borderless_monocle          = true;
            gapless_monocle             = true;
            focus_follows_pointer       = true;
            pointer_follows_focus       = false;

            merge_overlapping_monitors  = true;
            remove_disabled_monitors    = true;
            remove_unplugged_monitors   = true;

            ignore_ewmh_focus           = true;

            pointer_modifier            = "mod4";
            pointer_action1             = "move";
            pointer_action2             = "resize_side";
            pointer_action3             = "resize_corner";

            ##########
            # Colors #
            ##########
            normal_border_color         = "#282828";
            active_border_color         = "#282828";
            focused_border_color        = "#ebdbb2";
            presel_feedback_color       = "#ebdbb2";
            urgent_border_color         = "#cc241d";
        };


        extraConfig = ''

            # Add custom rules for Spotify and zotero
            # TODO enable
            # bspc config external_rules_command "$XDG_CONFIG_HOME/bspwm/custom_rules.sh"

            # Automatically set certain worskpaces' layout
            bspc desktop 2 -l monocle
            bspc desktop 4 -l monocle
            bspc desktop 7 -l monocle
            bspc desktop 8 -l monocle
        '';

        startupPrograms = [
            "signal-desktop"
            "pidof nextcloud || nextcloud"
            "sudo g610-led -a ff"
            "killall polybar; MONITOR=HDMI-1 polybar bar -r"
        ];
    };
}
