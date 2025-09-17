{ config, ... }:
{
  flake.modules.homeManager.core.imports = with config.flake.modules.homeManager; [
    agenix
    home-manager
    nix
    nix-index-database
    nh
    xdg
  ];
}
