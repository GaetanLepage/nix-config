{ config, ... }:
{
  flake.modules.homeManager.core.imports = with config.flake.modules.homeManager; [
    home-manager
    nix-index-database
    substituters
  ];
}
