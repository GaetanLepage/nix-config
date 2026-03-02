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

      programs.ssh.matchBlocks =
        lib.mapAttrs
          (
            _: v:
            {
              user = primaryUser;
              identityFile = config.age.secrets.ssh-perso.path;
            }
            // v
          )
          {
            ########
            # Home #
            ########

            framework.hostname = "10.10.10.2";
            cuda.hostname = "10.10.10.5";
            jrs = {
              hostname = "jonringer.us";
              user = "glepage";
              identityFile = config.age.secrets.ssh-jonringer-server.path;
              port = 2222;
            };
            tank = {
              hostname = "tank.glepage.com";
              port = 222;
            };
            borg = {
              hostname = "zh5071.rsync.net";
              user = "zh5071";
            };

            vps.hostname = "vps.glepage.com";

            pixel = {
              hostname = "10.10.10.3";
              port = 2222;
            };

            # Explicitly add them so that ssh-perso is used to authentificate
            "github.com" = { };
            "gitlab.com" = { };
            "codeberg.org" = { };

            #################
            # Lepage Knives #
            #################
            vps-lepage-knives = {
              host = "lk lepage-knives vps.lepage-knives.com";
              hostname = "vps.lepage-knives.com";
              user = "root";
            };
            borg-lk = {
              hostname = "zh5001.rsync.net";
              user = "zh5001";
            };

            ##############
            # Cordineaux #
            ##############
            backup.hostname = "10.10.10.4";
          };
    };
}
