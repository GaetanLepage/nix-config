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

  sshKeysPathPrefix = "${homeDirectory}/.ssh/";

  nix.package = pkgs.nix;
}
