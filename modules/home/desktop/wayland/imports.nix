{ config, ... }:
{
  flake.modules.homeManager.wayland.imports = with config.flake.modules.homeManager; [
    foot
    gammastep
    rofi
  ];
}
