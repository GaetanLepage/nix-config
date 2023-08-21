{pkgs, ...}: let
  backupScript =
    pkgs.writeShellApplication
    {
      name = "backup";
      text = builtins.readFile ./script.sh;
      runtimeInputs = with pkgs; [
        rsync
        libnotify
      ];
    };
  backupScriptPath = "${toString backupScript}/bin";
in {
  home = {
    sessionPath = [backupScriptPath];
    shellAliases.bu = "backup";
  };

  # Systemctl service
  systemd.user = {
    services.backup = {
      Unit.Description = "Home backup script";

      Service = {
        Type = "oneshot";
        Environment = "SSH_AUTH_SOCK=/run/user/1000/keyring/ssh";
        ExecStart = "${pkgs.bash}/bin/bash -l -c ${backupScriptPath}/backup";
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
