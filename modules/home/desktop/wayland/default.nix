{ config, ... }:
{
  flake.modules.homeManager.wayland = {
    imports = with config.flake.modules.homeManager; [
      rofi
    ];
  };
}
