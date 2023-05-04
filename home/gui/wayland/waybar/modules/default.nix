pkgs: {
  # LEFT
  "sway/workspaces" = {
    persistent_workspaces = {
      "1" = [];
      "2" = [];
      "3" = [];
      "4" = [];
      "5" = [];
      "6" = [];
      "7" = [];
      "8" = [];
      "9" = [];
      "10" = [];
    };
    enable-bar-scroll = true;
    disable-scroll-wraparound = true;
  };

  # CENTER
  "custom/spotify" = import ./spotify.nix pkgs;

  # RIGHT
  backlight = {
    device = "intel_backlight";
    format = " {percent}%";
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    format-bluetooth = "{volume}% {icon}";
    format-muted = "婢 muted";
    format-icons = {
      headphone = "";
      hands-free = "";
      headset = "";
      default = "墳";
    };

    # Interaction
    scroll-step = 5;
    on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
    on-click-right = "pavucontrol";
  };

  memory = {
    interval = 1;
    format = "  {:02}%";
  };

  cpu = {
    interval = 1;
    tooltip = false;
    # format = " {usage:02}%";
    format = " {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7} {usage:02}%";
    format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
  };

  network = {
    tooltip = false;

    format = "{ifname}";
    format-wifi = " {essid}";
    format-ethernet = "󰈀 {ipaddr}";
    format-disconnected = "";
  };

  "custom/vpn" = import ./vpn.nix pkgs;

  battery = {
    tooltip = false;

    bat = "BAT0";
    adapter = "AC0";

    format = "{icon}  {capacity}%";
    format-full = "{icon}  {capacity}% ﮣ";
    format-charging = "{icon}  {capacity}% ﮣ";

    format-icons = ["" "" "" "" ""];
  };

  clock = {
    interval = 5;
    format = "  {:%H:%M}";
  };

  "clock#date" = {
    interval = 5;
    format = "  {:%d/%m/%Y}";
  };

  "custom/notifs" = import ./notifs.nix pkgs;

  tray = {
    icon-size = 20;
    spacing = 2;
  };
}
