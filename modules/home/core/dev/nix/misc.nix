{
  flake.modules.homeManager.core = {
    home = {
      sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
    };
  };
}
