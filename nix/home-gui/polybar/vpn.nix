{
    type = "custom/script";

    interval = 1;

    exec = "$XDG_CONFIG_HOME/polybar/vpn.sh";
    click-left = "$XDG_CONFIG_HOME/polybar/toggle_wireguard.sh";

    format.padding = 0;
}
