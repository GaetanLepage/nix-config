{ config, ... }:
{
  nixosHosts.vps = {
    unstable = false;
    tags = [ "server" ];

    modules = [
      config.flake.modules.nixos.server
      config.flake.modules.nixos.caddy
      ./_nixos
    ];
  };
}
