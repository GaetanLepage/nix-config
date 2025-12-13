{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      home = {
        username = lib.mkDefault "gaetan";
        homeDirectory = "/${if pkgs.stdenv.isLinux then "home" else "Users"}/${config.home.username}";
      };
    };
}
