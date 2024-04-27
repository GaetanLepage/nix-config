{
  lib,
  config,
  ...
}: {
  options.my-modules.wireguard = {
    enable = lib.mkEnableOption "wireguard";

    ip = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = let
    cfg = config.my-modules.wireguard;
  in
    lib.mkIf cfg.enable {
      networking.wireguard.interfaces.wg0 = {
        ips = ["${cfg.ip}/32"];
        listenPort = 51820;
        privateKeyFile = config.age.secrets.wireguard-private-key.path;

        peers = [
          {
            endpoint = "glepage.com:51820";
            publicKey = "jWzlVwkNkaO1uj7Qh+Xemo0EtxIYP2ufK+18oPcdvBY=";

            # Forward all the traffic via VPN.
            #allowedIPs = [ "0.0.0.0/0" ];
            # Or forward only particular subnets
            allowedIPs = ["10.10.10.0/24"];

            # Send keepalives every 25 seconds. Important to keep NAT tables alive.
            persistentKeepalive = 25;
          }
        ];
      };
    };
}
