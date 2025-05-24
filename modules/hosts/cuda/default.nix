{ config, ... }:
{
  nixosHosts.cuda = {
    hasHM = true;
    unstable = true;
    deploy.remoteBuild = true;

    imports = with config.flake.modules.nixos; [
      dev
    ];
  };
}
