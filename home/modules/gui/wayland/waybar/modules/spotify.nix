pkgs: {
  format = "󰝚  {}";

  interval = 1;

  # Pause current song when clicking on the widget
  on-click = "${pkgs.playerctl}/bin/playerctl -p spotify play-pause";

  # Focus spotify when right-clicking on the widget
  on-click-right = toString (pkgs.writeShellScript "focus-spotify" ''
    spotify_id=$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq '.. | objects | select(.name == "Spotify Premium") | .id')
    ${pkgs.sway}/bin/swaymsg \[con_id=$spotify_id\] focus
  '');

  # Disable hover
  tooltip = false;

  exec = let
    python = pkgs.python3.withPackages (ps: [ps.dbus-python]);
  in "${python}/bin/python ${./spotify.py} -f '{artist} ~ {song}' -t 60";
}
