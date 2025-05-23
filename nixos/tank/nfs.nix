{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server = {
    enable = true;

    exports =
      let
        options = "rw,sync,no_subtree_check";
      in
      ''
        # wireguard
        /tank           192.168.1.101/32(${options}) 10.10.10.0/24(${options})

        # Everyone
        # /tank/share     192.168.1.0/24(${options})
      '';
  };
}
