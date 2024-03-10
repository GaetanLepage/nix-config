{
  pkgs,
  lib,
  ...
}: let
  backupScript =
    pkgs.writeShellApplication
    {
      name = "backup";
      text =
        builtins.readFile
        (pkgs.substituteAll {
          src = ./script.sh;
          excludes = ./excludes.txt;
        });
      runtimeInputs = with pkgs; [
        rsync
        libnotify
      ];
    };
in {
  home = {
    packages = [backupScript];
    shellAliases.bu = "backup";
  };

  # Systemctl service
  systemd.user = {
    services.backup = {
      Unit.Description = "Home backup script";

      Service = {
        Type = "oneshot";
        Environment = "SSH_AUTH_SOCK=/run/user/1000/keyring/ssh";
        ExecStart = lib.getExe backupScript;
      };
    };

    timers.backup = {
      Unit.Description = "Home backup script";

      Timer = {
        OnCalendar = "*-*-* 13:00:00";
        Unit = "backup.service";
      };

      Install.WantedBy = ["timers.target"];
    };
  };
}
