{
  flake.modules.homeManager.core =
    {
      osConfig,
      lib,
      ...
    }:
    {
      programs.ssh.matchBlocks =
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

          getIdentityFile = keyName: sshKeysPathPrefix + keyName;
        in
        (import ./_inria.nix {
          # inria
          inherit lib;
          identityFile = getIdentityFile "inria";
        })
        // (import ./_perso.nix {
          inherit lib;
          identityFile = getIdentityFile "perso";
        });
    };
}
