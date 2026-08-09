{ config, ... }:
{
  nixosHosts.spark = {
    system = "aarch64-linux";
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      dev
    ]);
  };
}
