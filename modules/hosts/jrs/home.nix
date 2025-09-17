{
  flake.modules.homeManager.host_jrs =
    { pkgs, ... }:
    {
      home.username = "glepage";

      programs.nh.flake = "github:GaetanLepage/nix-config";

      nix.package = pkgs.nix;
    };
}
