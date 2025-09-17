{
  flake.modules.homeManager.core =
    {
      lib,
      osConfig ? null,
      ...
    }:
    {
      programs.ssh.matchBlocks =
        lib.mapAttrs
          (
            _: hostname:
            {
              inherit hostname;
              user = "glepage";
              setEnv.TERM = "xterm-256color";
            }
            // (lib.optionalAttrs (osConfig != null) {
              identityFile = osConfig.age.secrets.ssh-nix-community.path;
            })
          )
          {
            arm = "aarch64-build-box.nix-community.org";
            darwin = "darwin-build-box.nix-community.org";
            linux-build-box = "build-box.nix-community.org";
          };
    };
}
