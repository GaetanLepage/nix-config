{ config, ... }:
{
  nixosHosts.cuda = {
    unstable = true;
    deploy.remoteBuild = true;

    imports = with config.flake.modules.nixos; [
      dev
    ];
  };
}
