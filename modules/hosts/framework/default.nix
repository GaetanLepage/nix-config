{ config, ... }:
{
  nixosHosts.framework = {
    unstable = true;
    imports = with config.flake.modules.nixos; [
      dev
    ];
  };
}
