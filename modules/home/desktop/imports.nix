{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    dunst
    email
    gtk
    kanshi
    udiskie
    wayland
    zathura
  ];
}
