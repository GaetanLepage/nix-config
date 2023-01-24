{ config, pkgs, ... }:
{
    imports = [
        ./tui
        ./gui
    ];

    nixpkgs.config.allowUnfree = true;

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
        username = "gaetan";
        homeDirectory = "/home/gaetan";

        # This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new Home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update Home Manager without changing this value. See
        # the Home Manager release notes for a list of state version
        # changes in each release.
        stateVersion = "22.05";
    };

    # Backup script
    systemd.user = {
        services.backup = {
            Unit.Description = "Home backup script";

            Service = {
                Type = "oneshot";
                Environment = "SSH_AUTH_SOCK=/run/user/1000/keyring/ssh";
                ExecStart = "${pkgs.bash}/bin/bash -l -c ${config.home.homeDirectory}/${config.xdg.configFile.scripts.target}/backup";
            };
        };

        timers.backup = {

            Unit.Description = "Home backup script";

            Timer = {
                OnCalendar = "*-*-* 13:00:00";
                Unit = "backup.service";
            };

            Install.WantedBy = [ "timers.target" ];
        };
    };
}
