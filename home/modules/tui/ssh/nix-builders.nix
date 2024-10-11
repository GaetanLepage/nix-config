{
  lib,
  osConfig ? null,
  ...
}: {
  programs.ssh.matchBlocks =
    lib.mapAttrs (_: v:
      {
        inherit (v) hostname;
        user = "glepage";
        setEnv.TERM = "xterm-256color";
      }
      // (lib.optionalAttrs (v ? port) {
        inherit (v) port;
      })
      # inria
      // (lib.optionalAttrs (osConfig != null) {
        identityFile = osConfig.age.secrets.${v.sshKeyName}.path;
      }))
    {
      arm = {
        hostname = "aarch64.nixos.community";
        sshKeyName = "aarch64-build-box-ssh-key";
      };
      darwin = {
        hostname = "darwin-build-box.nix-community.org";
        sshKeyName = "darwin-build-box-ssh-key";
      };
      linux-build-box = {
        hostname = "build-box.nix-community.org";
        sshKeyName = "linux-build-box-ssh-key";
      };
      jrs = {
        hostname = "jonringer.us";
        sshKeyName = "ssh-jonringer-server";
        port = 2222;
      };
    };
}
