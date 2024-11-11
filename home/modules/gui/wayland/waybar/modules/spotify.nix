{
  lib,
  config,
  pkgs,
  ...
}: {
  format = "󰝚  {}";

  interval = 1;

  # Pause current song when clicking on the widget
  on-click = "${lib.getExe pkgs.playerctl} -p spotify play-pause";

  # Focus spotify when right-clicking on the widget
  on-click-right = lib.getExe (pkgs.writeShellApplication {
    name = "focus-spotify";

    runtimeInputs = [
      config.wayland.windowManager.sway.package
      pkgs.jq
    ];

    text = ''
      spotify_id=$(swaymsg -t get_tree | jq '.. | objects | select(.name == "Spotify Premium") | .id')
      swaymsg \[con_id="$spotify_id"\] focus
    '';
  });

  # Disable hover
  tooltip = false;

  exec = let
    script =
      pkgs.writers.writePython3
      "spotify-waybar"
      {
        libraries = with pkgs.python3Packages; [dbus-python];
        doCheck = false;
      } (
        builtins.readFile ./spotify.py
      );
  in "${script} -f '{artist} ~ {song}' -t 60";
}
