{ config, ... }:
{
  flake.modules.homeManager.host_framework = {
    imports = with config.flake.modules.homeManager; [
      desktop
      ssh-hosts
    ];
  };
}
