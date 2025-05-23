{
  lib,
  config,
  ...
}:
{
  options.my-modules.wireguard = {
    enable = lib.mkEnableOption "wireguard";

    ip = lib.mkOption {
      type = lib.types.str;
    };

    redirectAllTraffic = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    allowedIPs = lib.mkOption {
      type = lib.types.str;
    };
  };

  config =
    let
      cfg = config.my-modules.wireguard;

      localIp = "${cfg.ip}/32";
      dnsIp = "10.10.10.1";

      commonConfig = {
        listenPort = 51820;
        privateKeyFile = config.age.secrets.wireguard-private-key.path;

        peers = [
          {
            endpoint = "162.19.67.38:51820";
            publicKey = "jWzlVwkNkaO1uj7Qh+Xemo0EtxIYP2ufK+18oPcdvBY=";
            allowedIPs = [ cfg.allowedIPs ];

            # Send keepalives every 25 seconds. Important to keep NAT tables alive.
            persistentKeepalive = 25;
          }
        ];
      };
    in
    lib.mkIf cfg.enable (
      lib.mkMerge [
        (lib.mkIf cfg.redirectAllTraffic {

          my-modules.wireguard.allowedIPs = lib.mkDefault "0.0.0.0/0";

          networking.wg-quick.interfaces.wg0 = commonConfig // {
            address = [ localIp ];
            dns = [ dnsIp ];
            autostart = true;
          };
        })
        (lib.mkIf (!cfg.redirectAllTraffic) {

          my-modules.wireguard.allowedIPs = lib.mkDefault "10.10.10.0/24";

          networking = {
            # Use my own DNS server.
            # Using `networkmanager.insertNameservers` instead od `nameservers` ensures this server is added
            # first and takes the priority over other DNS servers.
            networkmanager.insertNameservers = [ dnsIp ];

            wireguard.interfaces.wg0 = commonConfig // {
              ips = [ localIp ];
            };
          };
        })
      ]
    );
}
