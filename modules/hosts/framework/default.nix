{ config, ... }:
{
  nixosHosts.framework = {
    hasHM = true;
    unstable = true;
    imports = with config.flake.modules.nixos; [
      dev
    ];
  };
}
