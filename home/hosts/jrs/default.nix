{pkgs, ...}: let
  homeDirectory = "/home/glepage";
in {
  imports = [
    ../../modules/tui
  ];

  home = {
    username = "glepage";
    inherit homeDirectory;
  };

  nix.package = pkgs.nix;
}
