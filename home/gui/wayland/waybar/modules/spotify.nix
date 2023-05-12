pkgs: {
  format = "󰝚  {}";

  interval = 1;

  on-click = "${pkgs.playerctl}/bin/playerctl -p spotify play-pause";
  on-click-right = "${pkgs.sway}/bin/swaymsg '[class=Spotify]' focus";

  # Disable hover
  tooltip = false;

  exec = let
    python = pkgs.python3.withPackages (ps: [ps.dbus-python]);
  in "${python}/bin/python ${./spotify.py} -f '{artist} ~ {song}' -t 60";
}
