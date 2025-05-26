{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    dunst
    email
    flameshot
    gtk
    kanshi
    udiskie
    wayland
    zathura
  ];
}
