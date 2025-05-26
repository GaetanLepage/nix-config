{ config, ... }:
{
  flake.modules.homeManager.core.imports = with config.flake.modules.homeManager; [
    homeManager
    nix
    nix-index-database
    substituters
    update-script
    xdg
  ];
}
