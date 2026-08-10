{ config, ... }:
{
  nixosHosts.spark = {
    system = "aarch64-linux";
    unstable = true;
    tags = [ "server" ];

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      dev
    ]);

    homeManagerModules = with config.flake.modules.homeManager; [
      ssh-hosts
    ];
  };
}
