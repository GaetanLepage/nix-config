{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    bg-stream
    desktop-programs
    dunst
    email
    firefox
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
