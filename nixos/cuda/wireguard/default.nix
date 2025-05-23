{
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  my-modules.wireguard = {
    enable = true;
    redirectAllTraffic = true;
    ip = "10.10.10.5";
  };
  # services.resolved.enable = true;
  # networking.wg-quick.interfaces.mullvad = {
  #   address = [ "10.74.39.28/32,fc00:bbbb:bbbb:bb01::b:271b/128" ];
  #   dns = [ "10.64.0.1" ];
  #   autostart = true;
  #   # listenPort = 51820;
  #   privateKeyFile = "/home/gaetan/temp/privatekey";
  #
  #   peers = [
  #     {
  #       endpoint = "193.32.127.67:51820";
  #       publicKey = "qcvI02LwBnTb7aFrOyZSWvg4kb7zNW9/+rS6alnWyFE=";
  #
  #       allowedIPs = [ "0.0.0.0/0,::0/0" ];
  #
  #       # Send keepalives every 25 seconds. Important to keep NAT tables alive.
  #       persistentKeepalive = 25;
  #     }
  #   ];
  # };

}
