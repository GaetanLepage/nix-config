{
  flake.modules.homeManager.core =
    { config, ... }:
    {
      home = {
        username = "gaetan";
        homeDirectory = "/home/${config.home.username}";
      };
    };
}
