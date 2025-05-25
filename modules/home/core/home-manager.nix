{
  flake.modules.homeManager.home-manager = {
    home.stateVersion = "24.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
