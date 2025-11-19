{
  flake.modules.homeManager.core = {
    nix = {
      distributedBuilds = true;

      settings.builders-use-substitutes = true;
    };
  };
}
