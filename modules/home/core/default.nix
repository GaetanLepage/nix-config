{ config, ... }:
{
  flake.modules.homeManager.core =
    { lib, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        homeManager
        nix-index-database
        substituters
      ];

      home = {
        username = lib.mkDefault "gaetan"; # inria (remove mkDefault)
        homeDirectory = lib.mkDefault "/home/gaetan"; # inria
      };
    };
}
