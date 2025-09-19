{
  flake.modules.homeManager.core =
    {
      lib,
      config,
      ...
    }:
    {
      age.secrets.ssh-nix-community = {
        rekeyFile = ./ssh-nix-community.age;
        mode = "600";
      };

      programs.ssh.matchBlocks =
        lib.mapAttrs
          (_: hostname: {
            inherit hostname;
            user = "glepage";
            setEnv.TERM = "xterm-256color";
            identityFile = config.age.secrets.ssh-nix-community.path;
          })
          {
            arm = "aarch64-build-box.nix-community.org";
            darwin = "darwin-build-box.nix-community.org";
            linux-build-box = "build-box.nix-community.org";
          };
    };
}
