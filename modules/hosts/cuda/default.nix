{ config, ... }:
{
  nixosHosts.cuda = {
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      desktop
      dev
      nvidia
    ]);
  };
}
