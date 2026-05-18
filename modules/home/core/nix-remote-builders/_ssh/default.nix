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

  home.shellAliases = {
    sb = "ssh builder";
    sd = "ssh darwin";
    sba = "ssh builder -t zellij attach --create main";
  };

  programs.ssh.settings =
    let
      community-builders =
        lib.mapAttrs
          (_: HostName: {
            inherit HostName;
            user = "glepage";
            SetEnv.TERM = "xterm-256color";
            IdentityFile = config.age.secrets.ssh-nix-community.path;
          })
          {
            arm = "aarch64-build-box.nix-community.org";
            darwin-build-box = "darwin-build-box.nix-community.org";
            linux-build-box = "build-box.nix-community.org";
          };

      liberodark-builders =
        lib.mapAttrs
          (_: HostName: {
            User = "gaetan";
            inherit HostName;
            IdentityFile = config.age.secrets.ssh-liberodark.path;
          })
          {
            arm-liberodark = "build04.ynh.ovh";
            builder = "build02.ynh.ovh";
            darwin = "build03.ynh.ovh";
          };
    in
    community-builders // liberodark-builders;
}
