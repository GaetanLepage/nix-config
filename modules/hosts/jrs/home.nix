{
  flake.modules.homeManager.host_jrs =
    { pkgs, ... }:
    {
      home = {
        username = "glepage";
        homeDirectory = "/home/glepage";
      };

      programs.nh.flake = "github:GaetanLepage/nix-config";

      nix.package = pkgs.nix;
    };
}
