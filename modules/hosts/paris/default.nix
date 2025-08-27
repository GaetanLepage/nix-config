{ config, ... }:
{
  nixosHosts.paris = {
    unstable = true;
    deploy.remoteBuild = true;
  };

  flake.modules.nixos.host_paris.imports = with config.flake.modules.nixos; [
    dev
    ./_nixos
  ];
}
