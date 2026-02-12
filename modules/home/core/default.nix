{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      config,
      primaryUser,
      ...
    }:
    {
      home = {
        username = primaryUser;
      };
    };
}
