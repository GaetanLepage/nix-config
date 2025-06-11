{ config, ... }:
{
  nixosHosts.framework = {
    unstable = true;
  };

  flake.modules.nixos.host_framework.imports = with config.flake.modules.nixos; [
    desktop
    dev
  ];
}
