{
  config,
  pkgs,
  lib,
  ...
}:
{
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  # Enable both ipv4 and ipv6 forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking =
    let
      externalInterface = "ens3";
      internalInterface = "wg0";
      port = 51820;

      mkIpTablesCmd =
        exec: flag:
        "${lib.getExe' pkgs.iptables exec} -w -t nat -${flag} POSTROUTING -o ${externalInterface} -j MASQUERADE";

      mkPostCmd =
        flag:
        let
          ipv4Cmd = mkIpTablesCmd "iptables" flag;
          ipv6Cmd = mkIpTablesCmd "ip6tables" flag;
        in
        "${ipv4Cmd}; ${ipv6Cmd}";
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
        inherit externalInterface;
        internalInterfaces = [ internalInterface ];
      };

      wireguard.interfaces.${internalInterface} = {
        # Determines the IP address and subnet of the server's end of the tunnel interface.
        ips = [ "10.10.10.1/24" ];

        # The port that WireGuard listens to. Must be accessible by the client.
        listenPort = port;

        # This allows the wireguard server to route your traffic to the internet and hence be
        # like a VPN.
        # For this to work you have to set the dnsserver IP of your router (or dnsserver of
        # choice) in your clients
        postSetup = mkPostCmd "A";

        # This undoes the above command
        postShutdown = mkPostCmd "D";

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
