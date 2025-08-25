{
  flake.modules.homeManager.core =
    { lib, osConfig, ... }:
    let
      sshKeysPathPrefix =
        if
          osConfig ? age
        # if using NixOS + agenix:
        then
          "/run/agenix/ssh-"
        # on non-NixOS:
        else
          "~/.ssh/";
    in
    {
      programs.ssh = {
        enable = true;

        matchBlocks =
          lib.mapAttrs
            (
              _: v:
              {
                user = "gaetan";
                identityFile = sshKeysPathPrefix + "perso";
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
            };

      };
    };
}
