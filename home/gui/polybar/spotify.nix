{
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

  exec = "python $XDG_CONFIG_HOME/polybar/spotify.py -f '{artist} ~ {song}' -t 60";
}
