{ config, ... }:
{
  flake.modules.nixos.desktop.imports = with config.flake.modules.nixos; [
    bluetooth
    display-manager
    obs
    printing
    sound
    thunar
  ];
}
