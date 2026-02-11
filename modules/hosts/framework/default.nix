{ config, ... }:
{
  nixosHosts.framework = {
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      desktop
      dev
    ]);
  };
}
