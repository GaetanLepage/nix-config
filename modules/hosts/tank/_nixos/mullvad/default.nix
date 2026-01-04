{ config, ... }:
{
  age.secrets.mullvad-private-key.rekeyFile = ./private-key.age;

  networking.wg-quick.interfaces.mullvad =
    let
      ipv4 = "10.72.78.222/32";
      ipv6 = "fc00:bbbb:bbbb:bb01::9:4edd/128";
    in
    {
      address = [ "${ipv4},${ipv6}" ];
      dns = [ "10.64.0.1" ];
      autostart = true;
      # listenPort = 51820;
      privateKeyFile = config.age.secrets.mullvad-private-key.path;

      # Manually manage routes
      table = "off";
      postUp = ''
        ip route add default dev mullvad table 200
        ip -6 route add default dev mullvad table 200

        ip rule add from ${ipv4} table 200
        ip -6 rule add from ${ipv6} table 200
      '';

      postDown = ''
        ip rule del from ${ipv4} table 200
        ip -6 rule del from ${ipv6} table 200

        ip route del default dev mullvad table 200
        ip -6 route del default dev mullvad table 200
      '';

      peers = [
        {
          endpoint = "193.32.127.66:51820";
          publicKey = "/iivwlyqWqxQ0BVWmJRhcXIFdJeo0WbHQ/hZwuXaN3g=";

          allowedIPs = [ "0.0.0.0/0,::0/0" ];

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
}
