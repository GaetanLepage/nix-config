{ config, ... }:
{
  nixosHosts.tank = {
    unstable = false;

    modules = [
      config.flake.modules.nixos.server
      ./_nixos
    ];
  };
}
