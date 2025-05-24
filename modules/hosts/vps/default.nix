{ config, ... }:
{
  nixosHosts.vps = {
    unstable = false;
  };
  flake.modules.nixos.host_vps.imports = with config.flake.modules.nixos; [
    server
  ];
}
