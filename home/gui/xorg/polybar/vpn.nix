pkgs: {
  type = "custom/script";

  interval = 1;

  exec = pkgs.writeShellScript "vpn-polybar" ''

    type nmcli >/dev/null 2>&1 || exit

    ${builtins.readFile ./helper.sh}

    is_con_active() {
        return `nmcli connection show --active | grep $1 > /dev/null`
    }

    if `is_con_active wireguard`; then
        echo " wireguard"

    elif `is_con_active vpn_inria`; then
        echo " inria"

    else
        print_line " no vpn " $RED
    fi
  '';

  click-left = builtins.toString ./toggle_wireguard.sh;

  format.padding = 0;
}
