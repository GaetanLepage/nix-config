{ config, ... }:
{
  flake.modules.homeManager.desktop = {
    imports = with config.flake.modules.homeManager; [
      email
      kanshi
      wayland
    ];
  };
}
