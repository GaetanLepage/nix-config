{
  osConfig,
  lib,
  ...
}: {
  imports = [
    ./nix-builders.nix
  ];

  programs.ssh = {
    enable = true;

    matchBlocks = let
      sshKeysPathPrefix =
        if osConfig ? age
        # if using NixOS + agenix:
        then "/run/agenix/ssh-"
        # on non-NixOS:
        else "~/.ssh/";

      getIdentityFile = keyName: sshKeysPathPrefix + keyName;
    in
      (import ./gricad.nix {
        # inria
        inherit lib;
        identityFile = getIdentityFile "gricad";
      })
      // (import ./inria.nix {
        # inria
        inherit lib;
        identityFile = getIdentityFile "inria";
      })
      // (import ./perso.nix {
        inherit lib;
        identityFile = getIdentityFile "perso";
      });
  };

  home.shellAliases = {
    s = "ssh";
    sa = "ssh alya"; # inria
    sc = "ssh cuda";
    sj = "ssh jrs";
  };
}
