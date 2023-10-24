{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;

    matchBlocks = let
      getIdentityFile = keyName: "${config.home.homeDirectory}/config/secrets/ssh/${keyName}";
    in
      {
        "*".identityFile = getIdentityFile "perso";
      }
      // (import ./gricad.nix {
        inherit lib;
        identityFile = getIdentityFile "gricad";
      })
      // (import ./inria.nix {
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
    sa = "ssh alya";
    sam = "ssh alya -t tmux attach-session -t hm";
    si = "ssh -J bastion -l galepage";
    sc = "ssh cuda";
  };
}
