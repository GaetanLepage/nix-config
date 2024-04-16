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
      proxyJump = "bastion";
    };

    chamaeleon = {
      user = "gaetan";
      hostname = "10.10.10.6";
    };
  }
  // (
    lib.genAttrs
    [
      "access2-cp"
      "gpu*-perception"
      "alya"
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
        proxyJump = "bastion";
        setEnv.TERM = "xterm-256color";
      }
    )
  )
)
