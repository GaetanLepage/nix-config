{
  config,
  pkgs,
  lib,
  ...
}:
{
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  networking =
    let
      external_interface = "ens3";
      port = 51820;
    in
    {
      # Open ports
      firewall = {
        allowedTCPPorts = [ 53 ];
        allowedUDPPorts = [
          53
          port
        ];
      };

      # enable NAT
      nat = {
        enable = true;
        externalInterface = external_interface;
        internalInterfaces = [ "wg0" ];
      };

      wireguard.interfaces.wg0 = {
        # Determines the IP address and subnet of the server's end of the tunnel interface.
        ips = [ "10.10.10.1/24" ];

        # The port that WireGuard listens to. Must be accessible by the client.
        listenPort = port;

        # This allows the wireguard server to route your traffic to the internet and hence be
        # like a VPN.
        # For this to work you have to set the dnsserver IP of your router (or dnsserver of
        # choice) in your clients
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o ${external_interface} -j MASQUERADE
        '';

        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.10.10.0/24 -o ${external_interface} -j MASQUERADE
        '';

        # Path to the private key file.
        #
        # Note: The private key can also be included inline via the privateKey option,
        # but this makes the private key world-readable; thus, using privateKeyFile is
        # recommended.
        privateKeyFile = config.age.secrets.wireguard-private-key.path;
        # >>> PUBLIC KEY: jWzlVwkNkaO1uj7Qh+Xemo0EtxIYP2ufK+18oPcdvBY=

        # List of allowed peers.
        peers = lib.mapAttrsToList (publicKey: id: {
          inherit publicKey;
          allowedIPs = [ "10.10.10.${toString id}/32" ];
        }) (import ./peers.nix);
      };
    };
}
