{
  # Open HTTP and HTTPS ports
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  users.users.gaetan.extraGroups = [ "caddy" ];

  services.caddy = {
    enable = true;

    reverseProxies."router.glepage.com" = {
      localIp = "192.168.1.1";
      vpn = true;
    };
  };
}
