{
  config,
  lib,
  ...
}: {
  # Gnome keyring
  services.gnome-keyring.enable = true;
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

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
      })
      // {
        arm = {
          hostname = "aarch64.nixos.community";
          user = "glepage";
          identityFile = getIdentityFile "aarch64-build-box";
          setEnv.TERM = "xterm-256color";
        };
      }
      // {
        darwin = {
          hostname = "darwin-build-box.nix-community.org";
          user = "glepage";
          identityFile = getIdentityFile "darwin-build-box";
          setEnv.TERM = "xterm-256color";
        };
      }
      // {
        linux-build-box = {
          hostname = "build-box.nix-community.org";
          user = "glepage";
          identityFile = getIdentityFile "linux-build-box";
          setEnv.TERM = "xterm-256color";
        };
      };
  };

  home.shellAliases = {
    s = "ssh";
    sa = "ssh alya";
    sc = "ssh cuda";
  };
}
