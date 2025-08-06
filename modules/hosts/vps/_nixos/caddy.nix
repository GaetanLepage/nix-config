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
      "jellyfin.${domain_name}".port = 8096;

      "cache.${domain_name}" = {
        localIp = "10.10.10.5";
        port = 5000;
      };
    };
  };
}
