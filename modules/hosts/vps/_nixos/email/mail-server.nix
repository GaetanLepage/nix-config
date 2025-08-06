{ inputs, config, ... }:
let
  base_domain = "glepage.com";
in
{
  imports = [
    inputs.simple-nixos-mailserver.nixosModule
  ];

  services.borgbackup.jobs.backup.paths = [
    config.mailserver.mailDirectory
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.${base_domain}";

    domains = [
      base_domain
    ];

    # Let the server create new (self signed) certificates on the fly.
    certificateScheme = "selfsigned";

    # Clashes with Adguard
    localDnsResolver = false;

    loginAccounts = import ./accounts.nix;

    backup.enable = true;
  };
}
