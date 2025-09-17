{
  flake.modules.homeManager.core =
    { lib, config, ... }:
    {
      imports = [
        ./_keys
      ];

      programs.ssh = {
        enable = true;

        # Explicitly declare default config and disable HM's vendored one.
        # This will be deprecated after some time.
        enableDefaultConfig = false;

        matchBlocks = {
          # Sane settings
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "no";
            compression = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "no";
          };
        }
        // (lib.mapAttrs
          (
            _: v:
            {
              user = "gaetan";
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
            paris.hostname = "10.10.10.4";
            builder = {
              hostname = "91.224.148.57";
              identityFile = config.age.secrets.ssh-builder.path;
            };
            jrs = {
              hostname = "jonringer.us";
              user = "glepage";
              identityFile = config.age.secrets.ssh-jonringer-server.path;
              port = 2222;
            };
            router = {
              hostname = "192.168.1.1";
              user = "root";
              extraOptions = {
                HostKeyAlgorithms = "+ssh-rsa";
                PubkeyAcceptedKeyTypes = "+ssh-rsa";
              };
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

            "github.com".user = "git";
            "gitlab.com".user = "git";

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
            feroe.hostname = "10.10.10.23";
          }
        );
      };
    };
}
