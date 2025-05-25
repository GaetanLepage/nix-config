{ config, ... }:
{
  flake.modules.homeManager.desktop = {
    imports = with config.flake.modules.homeManager; [
      dunst
      email
      gtk
      kanshi
      wayland
      zathura
    ];
  };
}
