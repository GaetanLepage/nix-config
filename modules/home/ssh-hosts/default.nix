{
  flake.modules.homeManager.ssh-hosts =
    {
      lib,
      config,
      primaryUser,
      ...
    }:
    {
      imports = [
        ./_keys

        ./_nixos_cuda.nix
      ];

      programs.ssh.settings =
        lib.mapAttrs
          (
            _: v:
            {
              User = primaryUser;
              IdentityFile = config.age.secrets.ssh-perso.path;
            }
            // v
          )
          {
            ########
            # Home #
            ########

            framework.HostName = "10.10.10.2";
            cuda.HostName = "10.10.10.5";
            jrs = {
              HostName = "jonringer.us";
              User = "glepage";
              IdentityFile = config.age.secrets.ssh-jonringer-server.path;
              Port = 2222;
            };
            tank = {
              HostName = "tank.glepage.com";
              Port = 222;
            };
            borg = {
              HostName = "zh5071.rsync.net";
              User = "zh5071";
            };

            vps.HostName = "vps.glepage.com";

            pixel = {
              HostName = "10.10.10.3";
              Port = 2222;
            };

            # Explicitly add them so that ssh-perso is used to authentificate
            "github.com".User = "git";
            "gitlab.com".User = "git";
            "codeberg.org".User = "git";

            #################
            # Lepage Knives #
            #################
            vps-lepage-knives = {
              Host = "lk lepage-knives vps.lepage-knives.com";
              HostName = "vps.lepage-knives.com";
              User = "root";
            };
            borg-lk = {
              HostName = "zh5001.rsync.net";
              User = "zh5001";
            };

            ##############
            # Cordineaux #
            ##############
            backup.HostName = "10.10.10.4";
          };
    };
}
