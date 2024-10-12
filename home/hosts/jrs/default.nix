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
  githubToken.enable = false;

  nix.package = pkgs.nix;
}
