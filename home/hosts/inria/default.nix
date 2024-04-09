{
  pkgs,
  lib,
  ...
}: let
  homeDirectory = "/home/galepage";
in {
  imports = [
    ../../modules/tui
    ./update.nix
    ./test_python_env.nix
  ];

  home = {
    username = "galepage";
    inherit homeDirectory;

    stateVersion = "22.11";

    sessionVariables = {
      LD_PRELOAD = "/lib/x86_64-linux-gnu/libnss_sss.so.2";
    };
  };

  sshKeysPathPrefix = "${homeDirectory}/.ssh/";
  githubToken.enable = false;

  programs.tmate.enable = true;

  programs.nixvim.plugins.cmp-tabby.host = lib.mkForce "localhost:8080";

  xdg.userDirs = with lib; {
    desktop = mkForce "${homeDirectory}/Desktop";
    documents = mkForce "${homeDirectory}/Documents";
    download = mkForce "${homeDirectory}/Downloads";
    music = mkForce "${homeDirectory}/Music";
    pictures = mkForce "${homeDirectory}/Pictures";
    publicShare = mkForce "${homeDirectory}/Public";
    templates = mkForce "${homeDirectory}/Templates";
    videos = mkForce "${homeDirectory}/Videos";
  };

  nix.package = pkgs.nix;
}
