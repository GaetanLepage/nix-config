{config, ...}: {
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  networking = {
    firewall.allowedUDPPorts = [51820];

    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wireguard.interfaces.wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = ["10.10.10.5/32"];
      listenPort = 51820;

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = config.age.secrets.wireguard-private-key.path;

      peers = [
        # For a client configuration, one peer entry for the server will suffice.

        {
          # Public key of the server (not a file path).
          publicKey = "jWzlVwkNkaO1uj7Qh+Xemo0EtxIYP2ufK+18oPcdvBY=";

          # Forward all the traffic via VPN.
          #allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          allowedIPs = ["10.10.10.0/24"];

          # Set this to the server IP and port.
          endpoint = "glepage.com:51820";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
