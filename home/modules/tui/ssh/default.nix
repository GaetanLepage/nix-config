{
  config,
  lib,
  ...
}: {
  imports = [
    ./nix-builders.nix
  ];

  # inria (no need for this complex implem when I'll be on NixOS-only)
  options.sshKeysPathPrefix = lib.mkOption {
    type = lib.types.str;
    default = "/run/agenix/ssh-";
  };

  config = {
    programs.ssh = {
      enable = true;

      matchBlocks = let
        getIdentityFile = keyName: config.sshKeysPathPrefix + keyName;
      in
        {
          "*".identityFile = getIdentityFile "perso";
        }
        // (import ./gricad.nix {
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
  };
}
