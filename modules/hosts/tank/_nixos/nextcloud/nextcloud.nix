{ config, pkgs, ... }:
{
  age.secrets = {
    nextcloud-secret-file = {
      rekeyFile = ./nextcloud-secret-file.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    nextcloud-adminpass-file = {
      rekeyFile = ./nextcloud-adminpass-file.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
  };

  users.groups.nextcloud.members = [
    "nextcloud"
  ];

  services.nextcloud = {

    enable = true;

    package = pkgs.nextcloud31;

    hostName = "cloud.glepage.com";

    # Use HTTPS for links
    https = true;

    datadir = "/tank/nextcloud";
    autoUpdateApps.enable = true;
    appstoreEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        calendar
        contacts
        cospend
        onlyoffice
        ;
    };

    # https://docs.nextcloud.com/server/27/admin_manual/configuration_files/files_locking_transactional.html
    configureRedis = true;

    phpOptions."opcache.interned_strings_buffer" = 32;

    secretFile = config.age.secrets.nextcloud-secret-file.path;

    config = {
      adminpassFile = config.age.secrets.nextcloud-adminpass-file.path;
      adminuser = "glepage";
    };

    settings = {
      trusted_proxies = [
        "127.0.0.1"
        "::1"
      ];

      # Further forces Nextcloud to use HTTPS
      overwriteprotocol = "https";

      # Allows to send emails
      mail_smtpmode = "smtp";
      mail_smtphost = "mail.glepage.com";
      mail_smtpport = 587; # STARTTLS
      mail_smtpauth = true;
      mail_smtpname = "nextcloud@glepage.com";
      # mail_smtppassword is in the `cfg.secretFile`
      mail_smtpstreamoptions.ssl = {
        allow_self_signed = true;
        verify_peer = false;
        verify_peer_name = false;
      };

      default_phone_region = "FR";

      # Some background jobs only run once a day.
      # When an hour is defined (timezone is UTC) for this config, the background jobs which
      # advertise themselves as not time-sensitive will be delayed during the “working” hours and
      # only run in the 4 hours after the given time.
      # This is e.g. used for activity expiration, suspicious login training, and update checks.

      # A value of 1 will only run these background jobs between 01:00am UTC and 05:00am UTC.
      maintenance_window_start = 1;
    };
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
