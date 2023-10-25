{
  identityFile,
  lib,
}: let
  mkProxyCommand = hostname: "ssh -q lepageg-ext@access-gricad.univ-grenoble-alpes.fr 'nc -w 60 ${hostname} %p'";
in
  lib.mapAttrs
  (
    blockName: blockConfig:
      {
        user = "lepageg-ext";
        inherit identityFile;
        setEnv.TERM = "xterm-256color";
      }
      // blockConfig
  )
  {
    bigfoot.proxyCommand = mkProxyCommand "bigfoot";

    cargo.proxyCommand = mkProxyCommand "cargo";

    "access-gricad.univ-grenoble-alpes.fr" = {};
    "trinity.univ-grenoble-alpes.fr" = {};
    "rotule.univ-grenoble-alpes.fr" = {};
  }
