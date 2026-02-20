{ config, ... }:
{
  flake.modules.homeManager.core.imports = with config.flake.modules.homeManager; [
    agenix
    dev
    home-manager
    nix
    nh
    xdg
  ];
}
