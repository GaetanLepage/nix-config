{ config, ... }:
{
  flake.modules.homeManager.desktop = {
    imports = with config.flake.modules.homeManager; [
      kanshi
    ];
  };
}
