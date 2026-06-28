{ inputs, config, ... }:
let
  base_domain = "glepage.com";
in
{
  imports = [
    inputs.simple-nixos-mailserver.nixosModule
  ];

  services = {
    borgbackup.jobs.backup.paths = [
      config.mailserver.storage.path
    ];

    # Caddy serves the ACME HTTP-01 challenge for ${fqdn} from the webroot
    # populated by security.acme. Listening only on HTTP (no auto-cert) so
    # Caddy does not race with security.acme for the same certificate.
    caddy.virtualHosts."http://${config.mailserver.fqdn}".extraConfig = ''
      root * /var/lib/acme/acme-challenge
      file_server
    '';
  };

  security.acme = {
    # https://letsencrypt.org/repository/#let-s-encrypt-subscriber-agreement
    acceptTerms = true;

    defaults.email = "gaetan@${base_domain}";
    certs.${config.mailserver.fqdn} = {
      webroot = "/var/lib/acme/acme-challenge";
      group = "caddy";
    };
  };

  mailserver = {
    enable = true;

    stateVersion = 3;

    fqdn = "mail.${base_domain}";

    domains = [
      base_domain
    ];

    # Clashes with Adguard
    localDnsResolver = false;

    # Reference the existing ACME configuration created by nginx
    x509.useACMEHost = config.mailserver.fqdn;

    accounts = import ./accounts.nix;

    backup.enable = true;
  };
}
