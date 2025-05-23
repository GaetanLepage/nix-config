{ lib, config, ... }:
let
  cfg = config.my-modules.cloudBackup;
in
{
  options = {
    my-modules.cloudBackup = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf cfg.enable (
    let
      rsyncUser = "zh5071";
      rsyncHost = "${rsyncUser}.rsync.net";

      rsyncRepo = "${rsyncUser}@${rsyncHost}:backup_${config.networking.hostName}";
      BORG_RSH = "ssh -i ${config.age.secrets.rsync-net-ssh-private-key.path}";
    in
    {
      age.secrets = {
        borg-backup-passphrase.rekeyFile = ./borg-backup-passphrase.age;

        # Public key:
        # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOvQpBqqhQlDnwmD6FvdPgD64thOTiez4P1EwQZTZqui
        rsync-net-ssh-private-key.rekeyFile = ./rsync-net-ssh-private-key.age;
      };

      # ssh-keyscan zh5071.rsync.net
      programs.ssh.knownHosts.${rsyncHost}.publicKey =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtclizeBy1Uo3D86HpgD3LONGVH0CJ0NT+YfZlldAJd";

      environment = {
        variables.BORG_RSH = BORG_RSH;
        shellAliases.list-borg-backups = "borg list ${rsyncRepo}";
      };

      services.borgbackup.jobs.backup = {
        paths = [ "/var/backup" ];
        encryption = {
          mode = "repokey";
          passCommand = "cat ${config.age.secrets.borg-backup-passphrase.path}";
        };
        environment = {
          BORG_RSH = BORG_RSH;

          # Required by rsync.net since May 2025
          # They do not support relying on the default 'borg' executable
          BORG_REMOTE_PATH = "borg14";
        };
        repo = rsyncRepo;
        compression = "auto,zstd";
        startAt = "daily";

        prune.keep = {
          within = "1d"; # Keep all archives from the last day
          daily = 7;
          weekly = 4;
          monthly = -1; # Keep at least one archive for each month
          yearly = 10;
        };
      };
    }
  );
}
