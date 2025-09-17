{
  flake.modules.homeManager.nh =
    { nhSwitchCommand, ... }:
    {
      home.shellAliases = {
        u = nhSwitchCommand;
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
