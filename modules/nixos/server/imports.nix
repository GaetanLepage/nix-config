{ config, ... }:
{
  flake.modules.nixos.server.imports = with config.flake.modules.nixos; [
    cloud-backup
  ];
}
