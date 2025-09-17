{
  flake.modules.homeManager.core =
    { lib, config, ... }:
    {
      home = {
        username = lib.mkDefault "gaetan";
        homeDirectory = "/home/${config.home.username}";
      };
    };
}
