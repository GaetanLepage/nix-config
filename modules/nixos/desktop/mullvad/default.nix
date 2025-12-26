{
  flake.modules.nixos.desktop =
    { config, ... }:
    {
      age.secrets.mullvad-private-key.rekeyFile = ./private-key.age;
      networking.wg-quick.interfaces.mullvad = {
        address = [ "10.68.186.120/32,fc00:bbbb:bbbb:bb01::5:ba77/128" ];
        dns = [ "10.64.0.1" ];
        autostart = false;
        listenPort = 51820;
        privateKeyFile = config.age.secrets.mullvad-private-key.path;

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
    };
}
