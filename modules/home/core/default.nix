{
  flake.modules.homeManager.core =
    { lib, ... }:
    {
      home = {
        username = lib.mkDefault "gaetan"; # inria (remove mkDefault)
        homeDirectory = lib.mkDefault "/home/gaetan"; # inria
      };
    };
}
