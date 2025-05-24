{ config, ... }:
{
  nixosHosts.framework = {
    hasHM = true;
    unstable = true;
  };

  flake.modules.nixos.host_framework.imports = with config.flake.modules.nixos; [
    dev
  ];
}
