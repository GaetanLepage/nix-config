{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server = {
    enable = true;

    exports = ''
      /home/gaetan 10.10.10.2/32(rw,sync,no_subtree_check)
    '';
  };
}
