{
  flake.modules.homeManager.core =
    { lib, config, ... }:
    {
      home = {
        username = lib.mkDefault "gaetan"; # inria (remove mkDefault)
        homeDirectory = "/home/${config.home.username}";
      };
    };
}
