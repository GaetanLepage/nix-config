{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    desktop-programs
    dunst
    email
    firefox
    flameshot
    gtk
    kanshi
    keyring
    udiskie
    wayland
    zathura
  ];
}
