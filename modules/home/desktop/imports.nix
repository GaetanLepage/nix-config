{ config, ... }:
{
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    bg-stream
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
    streaming
    sway
    swaylock
    udiskie
    waybar
    wayland
    zathura
  ];
}
