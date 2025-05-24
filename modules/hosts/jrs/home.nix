{
  flake.modules.homeManager.host_jrs =
    { pkgs, ... }:
    {
      home = {
        username = "glepage";
        homeDirectory = "/home/glepage";
      };

      nix.package = pkgs.nix;
    };
}
