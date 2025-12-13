{ lib, config, ... }:
{
  age.secrets =
    lib.genAttrs'
      [
        # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOupOoulINUeCUKLfBllcS1Rulc1LzYnIOITXqEyYaao
        "nix-community"

        # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJfOUACs5oAn4Hyt6uMM5e/Xux0/5ODvSeg5zOy4MY1b
        "liberodark"
      ]
      (name': {
        name = "ssh-${name'}";

        value = {
          rekeyFile = ./${name'}.age;
          mode = "600";
        };
      });

  programs.ssh.matchBlocks =
    let
      community-builders =
        lib.mapAttrs
          (_: hostname: {
            inherit hostname;
            user = "glepage";
            setEnv.TERM = "xterm-256color";
            identityFile = config.age.secrets.ssh-nix-community.path;
          })
          {
            arm = "aarch64-build-box.nix-community.org";
            darwin-build-box = "darwin-build-box.nix-community.org";
            linux-build-box = "build-box.nix-community.org";
          };

      liberodark-builders =
        lib.mapAttrs
          (_: hostname: {
            user = "gaetan";
            inherit hostname;
            identityFile = config.age.secrets.ssh-liberodark.path;
          })
          {
            builder = "91.224.148.57";
            darwin = "91.224.148.58";
          };
    in
    community-builders // liberodark-builders;
}
