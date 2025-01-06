{
  lib,
  osConfig ? null,
  ...
}:
{
  programs.ssh.matchBlocks =
    lib.mapAttrs
      (
        _: v:
        {
          inherit (v) hostname;
          user = "glepage";
          setEnv.TERM = "xterm-256color";
          forwardAgent = v.forwardAgent or null;
          port = v.port or null;
        }
        # inria
        // (lib.optionalAttrs (osConfig != null) {
          identityFile = osConfig.age.secrets.${v.sshKeyName}.path;
        })
      )
      {
        arm = {
          hostname = "aarch64-build-box.nix-community.org";
          sshKeyName = "linux-build-box-ssh-key";
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
          forwardAgent = true;
        };
      };
}
