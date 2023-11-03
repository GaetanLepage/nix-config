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
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "galepage";
    inherit homeDirectory;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";

    sessionVariables = {
      LD_PRELOAD = "/lib/x86_64-linux-gnu/libnss_sss.so.2";
    };
  };

  programs.tmate.enable = true;

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
