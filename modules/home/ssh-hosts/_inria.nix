# inria
{ lib, config, ... }:
{
  programs.ssh.matchBlocks =
    let
      workstations =
        lib.genAttrs
          [
            "access2-cp"
            "gpu*-perception"
            "alya"
            "andromeda"
            "auriga"
            "bacchus"
            "carina"
            "chamaeleon"
            # "hydra"
            "kapelos"
            "mensa"
            "octans"
            "peirasmos"
            "pictor"
            "scorpio"
            "ursa"
            "virgo"
          ]
          (_: {
            proxyJump = "bastion";
            setEnv = {
              TERM = "xterm-256color";
            };
          });

    in
    lib.mapAttrs
      (
        blockName: blockConfig:
        {
          user = "galepage";
          identityFile = config.age.secrets.ssh-inria.path;
        }
        // blockConfig
      )
      (
        {
          bastion.hostname = "ssh-gra.inria.fr";

          "gitlab.inria.fr" = { };

          # Generic rule for all Inria computers
          "*.inrialpes.fr" = {
            proxyJump = "bastion";
          };

          g5k = {
            hostname = "access.grid5000.fr";
            user = "glepage";
          };
          abaca = {
            hostname = "grenoble";
            user = "glepage";
            proxyJump = "g5k";
            setEnv.TERM = "xterm-256color";
          };
        }
        // workstations
      );
}
