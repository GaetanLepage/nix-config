{ config, ... }:
{
  flake.modules.homeManager.core = {
    imports = with config.flake.modules.homeManager; [
      substituters
    ];
  };
}
