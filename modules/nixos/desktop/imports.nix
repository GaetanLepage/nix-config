{ config, ... }:
{
  flake.modules.nixos.desktop.imports = with config.flake.modules.nixos; [
    display-manager
    obs
    printing
    sound
    thunar
  ];
}
