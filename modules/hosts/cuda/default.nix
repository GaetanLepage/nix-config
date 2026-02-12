{ config, ... }:
{
  nixosHosts.cuda = {
    unstable = true;

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      desktop
      dev
      nvidia
    ]);

    homeManagerModules = [
      ./_home.nix
    ]
    ++ (with config.flake.modules.homeManager; [
      csConfig
      desktop
      ssh-hosts
    ]);
  };
}
