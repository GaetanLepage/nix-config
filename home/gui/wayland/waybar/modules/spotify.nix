pkgs: {
  type = "custom/script";

  interval = 1;

  click = {
    left = "playerctl -p spotify play-pause";
    right = "bspc desktop -f 9";
  };

  format = {
    text = "<label>";
    prefix = " ";
  };

  exec = let
    python = pkgs.python3.withPackages (ps: [ps.dbus-python]);
  in "${python}/bin/python ${./spotify.py} -f '{artist} ~ {song}' -t 60";
}
