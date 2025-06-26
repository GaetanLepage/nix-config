{
  flake.modules.homeManager.nh =
    { config, ... }:
    {
      home.shellAliases = {
        u = "nh os switch -u";
        nrs = "nh os switch";
      };
      programs.nh = {
        enable = true;

        flake = "${config.home.homeDirectory}/config";

        clean = {
          enable = true;

          dates = "daily";
          extraArgs = "--keep 1 --keep-since 8d";
        };
      };
    };
}
