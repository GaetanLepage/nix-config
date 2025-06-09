{ config, ... }:
{
  nixosHosts.tank = {
    unstable = false;
  };
  flake.modules.nixos.host_tank.imports = with config.flake.modules.nixos; [
    server
    ./_nixos
  ];
}
