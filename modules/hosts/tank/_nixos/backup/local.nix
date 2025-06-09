{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rsync ];

  systemd = {
    services.backup-var-to-tank = {
      description = "Script that periodically backups the /var directory to /tank/backup/var";
      after = [ "zfs-import.target" ];

      serviceConfig = {
        Type = "oneshot";
      };
      script = ''
        # Do not crash the service if the rsync command fails
        set +e

        # rsync backup command
        ${pkgs.rsync}/bin/rsync -rav --delete /var /tank/backup

        # Collect rsync exit code
        status=$?

        case $status in
            # Catch exit code 24 as this error is not important
            0|24) exit 0 ;;

            # In case of an error other than 24, crash the service
            *) exit 1 ;;
        esac
      '';
    };

    timers.backup-var-to-tank = {
      wantedBy = [ "timers.target" ];
      after = [ "multi-user.target" ];

      timerConfig = {
        OnCalendar = "hourly";
        Persistent = "yes";
      };
    };
  };
}
