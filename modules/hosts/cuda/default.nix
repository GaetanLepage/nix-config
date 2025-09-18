{ config, ... }:
{
  nixosHosts.cuda = {
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      dev
      desktop
      nvidia
    ]);
  };
}
