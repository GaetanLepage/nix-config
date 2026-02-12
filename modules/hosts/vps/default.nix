{ config, ... }:
{
  nixosHosts.vps = {
    unstable = false;

    modules = [
      config.flake.modules.nixos.server
      config.flake.modules.nixos.caddy
      ./_nixos
    ];
  };
}
