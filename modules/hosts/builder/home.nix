{
  flake.modules.homeManager.host_builder =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        nh.flake = "github:GaetanLepage/nix-config#builder";
      };

      nix.package = pkgs.nix;
    };
}
