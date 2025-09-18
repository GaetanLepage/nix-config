let
  domain_name = "glepage.com";
in
{
  # Open HTTP and HTTPS ports
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  users.users.gaetan.extraGroups = [ "caddy" ];

  services.caddy = {
    enable = true;

    virtualHosts = {
      ${domain_name}.extraConfig = ''
        handle_path /df {
            redir https://github.com/GaetanLepage/nix-config
        }

        root * /var/www/personal_website/
        encode gzip

        file_server browse
      '';
    };

    reverseProxies = {
      "bbox.${domain_name}" = {
        localIp = "feroe.${domain_name}";
        tlsInsecureSkipVerify = true;
        port = 6969;
        vpn = true;
      };
    };
  };
}
