{
  lib,
  pkgs,
}:
{
  interval = 1;

  # Disable hover
  tooltip = false;
  return-type = "json";

  exec =
    let
      nmcli = lib.getExe' pkgs.networkmanager "nmcli";
    in
    pkgs.writeShellScript "vpn-waybar" ''
      is_con_active() {
          return $(${nmcli} connection show --active | grep $1 > /dev/null)
      }

      if `is_con_active wireguard`; then
          echo '{"text": " wg"}'

      elif `is_con_active vpn_inria`; then
          echo '{"text": " inria"}'

      else
          echo '{"class": "disconnected", "text": " no vpn"}'
      fi
    '';

  on-click = lib.getExe (
    pkgs.writeShellApplication {
      name = "toggle-wireguard";

      runtimeInputs = with pkgs; [
        libnotify
        networkmanager
      ];

      text = ''
        if nmcli connection show --active | grep wireguard > /dev/null; then
            sudo systemctl stop wg-quick-wg0
            notify-send " wireguard off"

        else
            sudo systemctl start wg-quick-wg0
            notify-send " wireguard on"
        fi
      '';
    }
  );
}
