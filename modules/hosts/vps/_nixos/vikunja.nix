{ config, ... }:
let
  domain = "board.glepage.com";
in
{
  services = {
    caddy.reverseProxies.${domain} = {
      inherit (config.services.vikunja) port;
    };

    vikunja = {
      enable = true;
      frontendScheme = "https";
      frontendHostname = domain;

      settings = {
        service.allowiconchanges = false;
      };
    };
  };

  services.borgbackup.jobs.backup.paths = [
    config.services.vikunja.database.path
  ];
}
