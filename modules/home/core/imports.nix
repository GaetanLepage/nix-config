{ config, ... }:
{
  flake.modules.homeManager.core.imports = with config.flake.modules.homeManager; [
    home-manager
    nix
    nix-index-database
    substituters
    update-script
    xdg
  ];
}
