{ config, ... }:
let
  domain = "board.glepage.com";
in
{
  # 2026-06-28: pnpm is marked as insecure
  # https://github.com/NixOS/nixpkgs/issues/535579
  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-10.29.2"
  ];

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
