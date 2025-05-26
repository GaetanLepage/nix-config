{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    desktop-programs
    dunst
    email
    firefox
    flameshot
    foot
    gammastep
    gtk
    kanshi
    keyring
    rofi
    sway
    swaylock
    udiskie
    waybar
    wayland
    zathura
  ];
}
