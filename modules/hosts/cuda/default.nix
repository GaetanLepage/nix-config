{ config, ... }:
{
  nixosHosts.cuda = {
    unstable = true;
    deploy.remoteBuild = true;
  };

  flake.modules.nixos.host_cuda.imports = with config.flake.modules.nixos; [
    dev
    desktop
    nvidia
  ];
}
