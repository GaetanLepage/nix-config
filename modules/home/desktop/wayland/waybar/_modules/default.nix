{
  lib,
  pkgs,
  config,
}:
{
  # CENTER
  "custom/spotify" = import ./spotify.nix { inherit lib config pkgs; };

  # RIGHT
  backlight = {
    device = "intel_backlight";
    format = " {percent}%";
    scroll-step = 10.0;
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    format-bluetooth = "{volume}% {icon}";
    format-muted = "󰖁 muted";
    format-icons = {
      headphone = " ";
      hands-free = "󰋎";
      headset = "󰋎";
      default = "󰕾";
    };

    # Interaction
    scroll-step = 5;
    on-click = "${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-mute @DEFAULT_SINK@ toggle";
    on-click-right = lib.getExe pkgs.pavucontrol;
  };

  memory = {
    interval = 1;
    format = "  {:02}%";
  };

  cpu = {
    interval = 1;
    tooltip = false;
    # format = " {usage:02}%";
    format = "  {usage:02}%";
    # format = "  {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15} {usage:02}%";
    format-icons = [
      "▁"
      "▂"
      "▃"
      "▄"
      "▅"
      "▆"
      "▇"
      "█"
    ];
  };

  network = {
    tooltip = false;

    format = "{ifname}";
    format-wifi = "  {essid}";
    format-ethernet = "󰈀 {ipaddr}";
    format-disconnected = "";
  };

  "custom/vpn" = import ./vpn.nix { inherit pkgs lib; };

  battery = {
    tooltip = false;

    bat = "BAT1";
    adapter = "ACAD";

    format = "{icon}  {capacity}%";
    format-full = "{icon}  {capacity}% 󰚥";
    format-charging = "{icon}  {capacity}% 󰚥";

    format-icons = [
      ""
      ""
      ""
      ""
      ""
    ];
  };

  clock = {
    interval = 5;
    format = "  {:%H:%M}";
    tooltip = false; # disable hover
  };

  "clock#date" = {
    interval = 5;
    format = "  {:%d/%m/%Y}";
    tooltip = false; # disable hover
  };

  "custom/notifs" = import ./notifs.nix { inherit lib config pkgs; };

  tray = {
    icon-size = 20;
    spacing = 2;
  };
}
