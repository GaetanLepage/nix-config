{ config, ... }:
{
  flake.modules.nixos.core = {
    imports = with config.flake.modules.nixos; [
      nix
    ];
  };
}
