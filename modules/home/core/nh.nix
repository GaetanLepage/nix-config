{
  flake.modules.homeManager.nh =
    { lib, ... }:
    {
      home.shellAliases = {
        u = "nh os switch -u";
        nrs = "nh os switch";
      };

      programs.nh = {
        enable = true;

        flake = "github:GaetanLepage/nix-config";

        clean = {
          enable = true;

          dates = "daily";
          extraArgs = "--keep 1 --keep-since 8d";
        };
      };
    };
}
