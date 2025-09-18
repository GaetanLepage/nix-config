{ config, ... }:
{
  nixosHosts.vps = {
    unstable = false;

    modules = [
      config.flake.modules.nixos.server
      ./_nixos
    ];
  };
}
