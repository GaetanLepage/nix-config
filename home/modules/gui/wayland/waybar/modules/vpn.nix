pkgs: {
  interval = 1;

  # Disable hover
  tooltip = false;
  return-type = "json";

  exec = pkgs.writeShellScript "vpn-waybar" ''

    type nmcli >/dev/null 2>&1 || exit

    is_con_active() {
        return `nmcli connection show --active | grep $1 > /dev/null`
    }

    if `is_con_active wireguard`; then
        echo '{"text": " wg"}'

    elif `is_con_active vpn_inria`; then
        echo '{"text": " inria"}'

    else
        echo '{"class": "disconnected", "text": " no vpn"}'
    fi
  '';

  on-click = pkgs.writeShellScript "toggle-wireguard" ''

    if `nmcli connection show --active | grep wireguard > /dev/null`; then
        doas systemctl stop wg-quick-wg0
        notify-send " wireguard off"

    else
        doas systemctl start wg-quick-wg0
        notify-send " wireguard on"
    fi
  '';
}
