{
    type = "custom/script";

    interval = 1;
    exec = "$XDG_CONFIG_HOME/polybar/dunst.sh";
    click-left = "dunstctl set-paused toggle";

    format.padding = 0;
}
