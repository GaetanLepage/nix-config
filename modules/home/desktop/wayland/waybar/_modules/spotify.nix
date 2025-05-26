{
  lib,
  config,
  pkgs,
  ...
}:
{
  format = "󰝚  {}";

  interval = 1;

  # Pause current song when clicking on the widget
  on-click = "${lib.getExe pkgs.playerctl} -p spotify play-pause";

  # Focus spotify when right-clicking on the widget
  on-click-right =
    let
      swaymsg = lib.getExe' config.wayland.windowManager.sway.package "swaymsg";
    in
    "${swaymsg} \[app_id=spotify\] focus";

  # Disable hover
  tooltip = false;

  exec =
    let
      script = pkgs.writers.writePython3 "spotify-waybar" {
        libraries = with pkgs.python3Packages; [ dbus-python ];
        doCheck = false;
      } (builtins.readFile ./spotify.py);
    in
    "${script} -f '{artist} ~ {song}' -t 60";
}
