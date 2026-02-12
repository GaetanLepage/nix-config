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
        homeDirectory = "/${if pkgs.stdenv.isLinux then "home" else "Users"}/${config.home.username}";
      };
    };
}
