{config, ...}: {
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  networking.wg-quick.interfaces.wg0 = {
    address = ["10.10.10.2/32"];

    listenPort = 51820;
    dns = ["10.10.10.1"];

    autostart = true;

    privateKeyFile = config.age.secrets.wireguard-private-key.path;

    peers = [
      # For a client configuration, one peer entry for the server will suffice.
      {
        # Public key of the server (not a file path).
        publicKey = "jWzlVwkNkaO1uj7Qh+Xemo0EtxIYP2ufK+18oPcdvBY=";

        # Forward all the traffic via VPN.
        allowedIPs = ["0.0.0.0/0"];
        # Or forward only particular subnets
        # allowedIPs = [ "10.10.10.0/24" ];

        # Set this to the server IP and port.
        endpoint = "109.13.20.45:51820";

        # Send keepalives every 25 seconds. Important to keep NAT tables alive.
        persistentKeepalive = 25;
      }
    ];
  };
}
