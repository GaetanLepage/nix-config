{ config, ... }:
{
  nixosHosts.spark = {
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      dev
    ]);

    # homeManagerModules = [
    # ]
    # ++ (with config.flake.modules.homeManager; [
    #   ssh-hosts
    # ]);
  };
}
