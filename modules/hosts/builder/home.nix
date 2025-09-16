{
  flake.modules.homeManager.host_builder =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        nh.flake = "github:GaetanLepage/nix-config";
      };

      nix.package = pkgs.nix;
    };
}
