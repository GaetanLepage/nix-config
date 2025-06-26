{
  flake.modules.homeManager.nh =
    { lib, config, ... }:
    {
      home.shellAliases = {
        u = "nh os switch -u";
        nrs = "nh os switch";
      };
      programs.nh = {
        enable = true;

        flake = lib.mkDefault "${config.home.homeDirectory}/config";

        clean = {
          enable = true;

          dates = "daily";
          extraArgs = "--keep 1 --keep-since 8d";
        };
      };
    };
}
