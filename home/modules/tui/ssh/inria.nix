{
  identityFile,
  lib,
}:
lib.mapAttrs
(
  blockName: blockConfig:
    {
      user = "galepage";
      inherit identityFile;
    }
    // blockConfig
)
(
  {
    bastion.hostname = "ssh-gra.inria.fr";

    "gitlab.inria.fr" = {};

    # Generic rule for all Inria computers
    "*.inrialpes.fr" = {
      proxyJump = "alya";
    };

    chamaeleon = {
      hostname = "10.10.10.6";
      user = "gaetan";
    };

    cluster = {
      hostname = "access2-cp.inrialpes.fr";
      proxyJump = "alya";
    };

    # Workstations
    alya = {
      hostname = "10.10.10.4";
      # hostname = "alya.inrialpes.fr";
      # proxyJump = "bastion";

      setEnv = {
        # Pulse server forwarding
        PULSE_SERVER = "tcp:10.10.10.2:4713";
        TERM = "xterm-256color";
      };
    };
  }
  // (
    lib.genAttrs
    [
      "gpu*-perception"
      "andromeda"
      "auriga"
      "bacchus"
      "carina"
      "hydra"
      "kapelos"
      "mensa"
      "octans"
      "peirasmos"
      "pictor"
      "scorpio"
      "ursa"
      "virgo"
    ]
    (
      _: {
        proxyJump = "alya";
        setEnv.TERM = "xterm-256color";
      }
    )
  )
)
